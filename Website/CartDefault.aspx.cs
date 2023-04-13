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

            //========= Display page content

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
                //int productsPrice = 0;
                //foreach (ProductsList product in cartList) productsPrice += Int32.Parse(product.price);
                //products_price.InnerHtml = $"{productsPrice} <span class='cart__product-price-unit'>đ</span>";

                ////Display delivery price
                //const int DELIVERY = 50000;
                //delivery_price.InnerHtml = $"{DELIVERY} <span class='cart__product-price-unit'>đ</span>";

                ////Display order total price
                //int orderTotal = productsPrice + DELIVERY;
                //order_total_price.InnerHtml = $"{orderTotal} <span class='cart__product-price-unit'>đ</span>";
            }
        }
    }
}