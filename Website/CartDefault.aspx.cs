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
    public partial class CartDefault : System.Web.UI.Page
    {
        string con = ConfigurationManager.ConnectionStrings["dbconnection"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            Utility utility = new Utility();

            //========= Display page content==============
            List<ProductsList> productsLists = new List<ProductsList>();
            DataTable dataTable = utility.getAll_SanPham();

            foreach (DataRow row in dataTable.Rows)
            {
                ProductsList product = new ProductsList();
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
                List<ProductsList> cartList = new List<ProductsList>();
                string[] productsID = Request.Cookies["cart"].Value.Split(',');
                foreach (string productID in productsID)
                {
                    foreach (ProductsList product in productsLists)
                    {
                        if (product.idSanPham.ToString() == productID)
                        {
                            cartList.Add(product);
                        }
                    }
                }
                ListViewCart.DataSource = cartList;
                ListViewCart.DataBind();

                float productsPrice = 0;
                foreach (ProductsList product1 in cartList) productsPrice += product1.fDonGia;
                products_price.InnerHtml = $"{productsPrice} <span class='cart__product-price-unit'>đ</span>";

                ////Display delivery price
                const int DELIVERY = 50000;
                delivery_price.InnerHtml = $"{DELIVERY} <span class='cart__product-price-unit'>đ</span>";

                //Display order total price
                float orderTotal = productsPrice + DELIVERY;
                order_total_price.InnerHtml = $"{orderTotal} <span class='cart__product-price-unit'>đ</span>";
            }
        }

        public List<ProductsList> GetCartItems()
        {
            Utility utility = new Utility();

            //========= Display page content==============
            List<ProductsList> productsLists = new List<ProductsList>();
            DataTable dataTable = utility.getAll_SanPham();

            foreach (DataRow row in dataTable.Rows)
            {
                ProductsList product = new ProductsList();
                product.idSanPham = (int)row["iSanPhamId"];
                product.sTenSanPham = row["sTenSanPham"].ToString();
                product.sMoTa = row["sMoTa"].ToString();
                product.sAnh = row["sAnh"].ToString();
                product.fDonGia = (float)Convert.ToDouble(row["fDonGia"]);
                product.dThoiGianTao = (DateTime)row["dThoiGianTao"];
                product.idDanhmuc = (int)row["iDanhMucId"];
                productsLists.Add(product);
            }

            List<ProductsList> cartList = new List<ProductsList>();

            //Display products
            if (Request.Cookies["cart"] != null)
            {
               
                string[] productsID = Request.Cookies["cart"].Value.Split(',');
                foreach (string productID in productsID)
                {
                    foreach (ProductsList product in productsLists)
                    {
                        if (product.idSanPham.ToString() == productID)
                        {
                            cartList.Add(product);
                        }
                    }
                }
               
            }
            return cartList;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {

            //    //var orderDate = DateTime.UtcNow;
            //    //using (SqlConnection conn = new SqlConnection(con))
            //    //{
            //    //    using (SqlCommand cmd = new SqlCommand("INSERT INTO tblDonHang (iKhachHangId, sTenKhachHang, sEmail, sPhuongThucThanhToan, sPhone, sDiaChiGiao,dNgayDat,fTongTien, iTrangThai) " +
            //    //        "VALUES (@iKhachHangId, @sTenKhachHang, @sEmail, @sPhuongThucThanhToan, @sPhone, @sDiaChiGiao,@dNgayDat,@fTongTien,@iTrangThai); SELECT SCOPE_IDENTITY()", conn))
            //    //    {

            //    //        cmd.Connection = conn;
            //    //        cmd.Parameters.AddWithValue("@iKhachHangId", 5);
            //    //        cmd.Parameters.AddWithValue("@sTenKhachHang", "Minh123");
            //    //        cmd.Parameters.AddWithValue("@sEmail", "eminh123@gmail.com");
            //    //        cmd.Parameters.AddWithValue("@sPhuongThucThanhToan", "ck");
            //    //        cmd.Parameters.AddWithValue("@sPhone", "0123999");
            //    //        cmd.Parameters.AddWithValue("@sDiaChiGiao", "Ha Noi");
            //    //        cmd.Parameters.AddWithValue("@dNgayDat", orderDate);
            //    //        cmd.Parameters.AddWithValue("@fTongTien", 500000);
            //    //        cmd.Parameters.AddWithValue("@iTrangThai", 1);

            //    //            conn.Open();
            //    //        var orderId = (int)(decimal)cmd.ExecuteScalar();


            //    //        var cartItems = GetCartItems();
            //    //        foreach (var cartItem in cartItems)
            //    //        {
            //    //            var orderItemCommand = new SqlCommand("INSERT INTO tblChiTietDonHang ( iDonHangId,iSanPhamId, iSoluong, fDonGia) VALUES (@iDonHangId, @iSanPhamId, @iSoluong, @fDonGia)", conn);

            //    //            orderItemCommand.Parameters.AddWithValue("@iDonHangId", orderId);
            //    //            orderItemCommand.Parameters.AddWithValue("@iSanPhamId", cartItem.idSanPham);
            //    //            orderItemCommand.Parameters.AddWithValue("@iSoluong", 1);
            //    //            orderItemCommand.Parameters.AddWithValue("@fDonGia", cartItem.fDonGia);

            //    //            orderItemCommand.ExecuteNonQuery();
            //    //        }
            //    //    }
            //    //}
            Response.Redirect("FormCart.aspx");
        }
}
}