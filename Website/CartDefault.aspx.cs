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
            isLogin.InnerHtml = Convert.ToString(Session["login"]);

            Utility utility = new Utility();
            
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
                List<Product> cartList = new List<Product>();
                string[] productsID = Request.Cookies["cart"].Value.Split(',');
                foreach (string productID in productsID)
                {
                    foreach (Product product in productsLists)
                    {
                        if (product.idSanPham.ToString() == productID)
                        {
                            cartList.Add(product);
                        }
                    }
                }
                ListViewCart.DataSource = cartList;
                ListViewCart.DataBind();

                //float productsPrice = 0;
                float productLength = 0;
                foreach (Product product1 in cartList)
                {
                    //productsPrice += product1.fDonGia;
                    productLength++;
                }
                //products_price.InnerHtml = $"{productsPrice} <span class='cart__product-price-unit'>đ</span>";
                total_products.InnerHtml = $"{productLength}";

                ////Display delivery price
                //const int DELIVERY = 50000;
                //delivery_price.InnerHtml = $"{DELIVERY} <span class='cart__product-price-unit'>đ</span>";

                //Display order total price
                //float orderTotal = productsPrice + DELIVERY;
                //order_total_price.InnerHtml = $"{orderTotal} <span class='cart__product-price-unit'>đ</span>";
            }
        }

        public List<Product> GetCartItems()
        {
            Utility utility = new Utility();

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

            List<Product> cartList = new List<Product>();

            //Display products
            if (Request.Cookies["cart"] != null)
            {
               
                string[] productsID = Request.Cookies["cart"].Value.Split(',');
                foreach (string productID in productsID)
                {
                    foreach (Product product in productsLists)
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
            
            //if(Convert.ToInt32(Session["login"]) == 1 && Convert.ToInt32(Session["id"]) != 0)
            //{
            //    Response.Redirect("FormCart.aspx");
            //}else
            //{
            //    Response.Redirect("signIn.aspx");
            //}
        }
}
}