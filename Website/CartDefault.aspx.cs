using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Website
{
    public partial class CartDefault : System.Web.UI.Page
    {
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
                Utility utility = new Utility();
                //List<ProductsList> cartList = new List<ProductsList>();
                //List<ProductsList> productsLists = (List<ProductsList>)Application["productsList"];
                //string[] productsID = Request.Cookies["cart"].Value.Split(',');
                //foreach (string productID in productsID)
                //{
                //    foreach (ProductsList product in productsLists)
                //    {
                //        if (product.id == productID)
                //        {
                //            cartList.Add(product);
                //        }
                //    }
                //}

                //Display product information
                List<ProductsList> cartList = new List<ProductsList>();
                List<ProductsList> productLists = new List<ProductsList>();


                string[] productsID = Request.Cookies["cart"].Value.Split(',');
                
                
                foreach (string productID in productsID)
                {
                    string idSanPham = Request.QueryString.Get(productID);
                    DataTable dt = utility.get_ChiTiet_SanPham(productID);
                  
                    ListViewCart.DataSource = dt;
                    ListViewCart.DataBind();
                    //foreach (ProductsList product in dt)
                    //{
                    //    if (product.id == productID)
                    //    {
                    //        cartList.Add(product);
                    //    }
                    //}
                }
               

               

                //Display total products

                //Display products price
                float productsPrice = 0;
                foreach (ProductsList product1 in cartList) productsPrice += product1.fDonGia;
                products_price.InnerHtml = $"{productsPrice} <span class='cart__product-price-unit'>đ</span>";

                ////Display delivery price
                //const int DELIVERY = 50000;
                //delivery_price.InnerHtml = $"{DELIVERY} <span class='cart__product-price-unit'>đ</span>";

                //Display order total price
                float orderTotal = productsPrice + DELIVERY;
                order_total_price.InnerHtml = $"{orderTotal} <span class='cart__product-price-unit'>đ</span>";
            }
        }
    }
}