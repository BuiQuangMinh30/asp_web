using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Website
{
    public partial class FormCart : System.Web.UI.Page
    {
        string con = ConfigurationManager.ConnectionStrings["dbconnection"].ConnectionString;
        float productsPrice = 0;
        Utility utility = new Utility();
        protected void Page_Load(object sender, EventArgs e)
        {
            //Check chỉ PostBack lần đầu và  chỉ thực hiện các thao tác cần thiết
            //nếu trang được tải lên từ một yêu cầu POST từ trang khác
            if (!IsPostBack && Request.HttpMethod == "POST")
            {
                //========= Display page content==============
                List<Product> productsLists = new List<Product>();
                DataTable dataTable = utility.getAll_SanPham();

                foreach (DataRow row in dataTable.Rows)
                {
                    Product product = new Product();
                    product.idSanPham = (int)row["iSanPhamId"];
                    product.sTenSanPham = row["sTenSanPham"].ToString();
                    product.sMoTa = row["sMoTa"].ToString();
                    product.sAnh = row["sAnh"].ToString();
                    product.fDonGia = (float)Convert.ToDouble(row["fDonGia"]);
                    product.dThoiGianTao = (DateTime)row["dThoiGianTao"];
                    product.idDanhmuc = (int)row["iDanhMucId"];
                    productsLists.Add(product);
                }

                //Display products
                if (Request.Cookies["cart"] != null)
                {

                    //Display product information

                    //List<Product> cartItems = (List<Product>)Session["CartItems"];
                    //if (cartItems == null)
                    //{
                    //    cartItems = new List<Product>();
                    //}

                    string[] productsID = Request.Cookies["cart"].Value.Split(',');
                    // Tạo dictionary để lưu trữ sản phẩm trong giỏ hàng
                    Dictionary<int, CartItem> cartItems = new Dictionary<int, CartItem>();

                    int i = 0;
                    foreach (string productID in productsID)
                    {
                        foreach (Product product in productsLists)
                        {
                            if (product.idSanPham.ToString() == productID)
                            {
                                int soLuong = Convert.ToInt32(Request.Form["quantity[" + product.idSanPham + "][" + i + "]"]);
                                if (cartItems.ContainsKey(product.idSanPham))
                                {
                                    cartItems[product.idSanPham].iSoluong += soLuong;
                                    i++;
                                }
                                else
                                {
                                    //Dùng dictionary để lưu
                                    CartItem cartItem = new CartItem { iSanPhamId = product.idSanPham, iSoluong = soLuong, fDonGia = product.fDonGia, sTenSanPham = product.sTenSanPham, sAnh = product.sAnh };
                                    cartItems.Add(product.idSanPham, cartItem);
                                    i++;
                                }
                            }
                        }
                    }
                    if (Session["CartItems"] == null)
                    {
                        Session["CartItems"] = cartItems;
                    }
                }
            }
        }
        public List<Product> GetCartItems()
        {
            //Lấy data của tất cả sản phẩm
            List<Product> productsLists = new List<Product>();
            DataTable dataTable = utility.getAll_SanPham();
            foreach (DataRow row in dataTable.Rows)
            {
                Product product = new Product();
                product.idSanPham = (int)row["iSanPhamId"];
                product.sTenSanPham = row["sTenSanPham"].ToString();
                product.sMoTa = row["sMoTa"].ToString();
                product.sAnh = row["sAnh"].ToString();
                product.fDonGia = (float)Convert.ToDouble(row["fDonGia"]);
                product.dThoiGianTao = (DateTime)row["dThoiGianTao"];
                product.idDanhmuc = (int)row["iDanhMucId"];
                productsLists.Add(product);
            }


            //Lấy ra những mặt hàng có trong giỏ hàng
            List<Product> cartItems = (List<Product>)Session["CartItems"]; ;
            //Display products
            if (Request.Cookies["cart"] != null)
            {

                string[] productsID = Request.Cookies["cart"].Value.Split(',');

                int i = -1;
                foreach (string productID in productsID)
                {
                    foreach (Product product in productsLists)
                    {
                        if (product.idSanPham.ToString() == productID)
                        {
                            i++;
                            product.iSoLuong = Convert.ToInt32(Request.Form.Get("quantity[" + product.idSanPham + "][" + i + "]"));
                            cartItems.Add(product);
                        }
                    }
                }
            }
            if (Session["CartItems"] == null)
            {
                Session["CartItems"] = cartItems;
            }
            foreach (Product cartItem in cartItems)
            {
                productsPrice += cartItem.fDonGia * cartItem.iSoLuong;
            }
            return cartItems;
        }


        protected void btnAdd_Product_Click(object sender, EventArgs e)
        {
            var idUser = Convert.ToInt32(Session["id"]);
            string sTenkhachhang = Request.Form.Get("name");
            string sEmail = Request.Form.Get("email");
            string sPhone = Request.Form.Get("phone");
            string address = Request.Form.Get("address");
            string paymentMethod = Request.Form.Get("payment");
            var orderDate = DateTime.UtcNow;

            //Lấy ra từng cặp key-value  trong dictionary
            foreach (KeyValuePair<int, CartItem> cartItem in (Dictionary<int, CartItem>)Session["CartItems"])
            {
                productsPrice += cartItem.Value.fDonGia * cartItem.Value.iSoluong;
            }
            using (SqlConnection conn = new SqlConnection(con))
            {
                using (SqlCommand cmd = new SqlCommand("INSERT INTO tblDonHang (iKhachHangId, sTenKhachHang, sEmail, sPhuongThucThanhToan, sPhone, sDiaChiGiao,dNgayDat,fTongTien, iTrangThai) " +
                    "VALUES (@iKhachHangId, @sTenKhachHang, @sEmail, @sPhuongThucThanhToan, @sPhone, @sDiaChiGiao,@dNgayDat,@fTongTien,@iTrangThai); SELECT SCOPE_IDENTITY()", conn))
                {

                    cmd.Connection = conn;
                    cmd.Parameters.AddWithValue("@iKhachHangId", idUser);
                    cmd.Parameters.AddWithValue("@sTenKhachHang", sTenkhachhang.ToString());
                    cmd.Parameters.AddWithValue("@sEmail", sEmail.ToString());
                    cmd.Parameters.AddWithValue("@sPhuongThucThanhToan", paymentMethod);
                    cmd.Parameters.AddWithValue("@sPhone", sPhone.ToString());
                    cmd.Parameters.AddWithValue("@sDiaChiGiao", address.ToString());
                    cmd.Parameters.AddWithValue("@dNgayDat", orderDate);
                    cmd.Parameters.AddWithValue("@fTongTien", Convert.ToDouble(productsPrice + 50000));
                    cmd.Parameters.AddWithValue("@iTrangThai", 0);

                    conn.Open();
                    var orderId = (int)(decimal)cmd.ExecuteScalar();

                    int rs = 0;
                    //Lặp qua các key value trong dictionary
                    foreach (KeyValuePair<int, CartItem> cartItem in (Dictionary<int, CartItem>)Session["CartItems"])
                    {
                        var orderItemCommand = new SqlCommand("INSERT INTO tblChiTietDonHang ( iDonHangId,iSanPhamId, iSoluong, fDonGia) VALUES (@iDonHangId, @iSanPhamId, @iSoluong, @fDonGia)", conn);

                        orderItemCommand.Parameters.AddWithValue("@iDonHangId", orderId);
                        orderItemCommand.Parameters.AddWithValue("@iSanPhamId", cartItem.Value.iSanPhamId);
                        orderItemCommand.Parameters.AddWithValue("@iSoluong", cartItem.Value.iSoluong);
                        orderItemCommand.Parameters.AddWithValue("@fDonGia", cartItem.Value.fDonGia);

                        rs = orderItemCommand.ExecuteNonQuery();
                    }

                    if (rs > 0)
                    {
                        Response.Cookies["cart"].Value = "";
                        Response.Cookies["cart"].Expires = DateTime.Now.AddDays(-1);
                        Response.Redirect("CheckouSuccess.aspx");
                    }
                }
            }
        }
    }
}