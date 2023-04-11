using System;
using System.Collections.Generic;
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
                List<ProductsList> cartList = new List<ProductsList>();
                List<ProductsList> productsLists = (List<ProductsList>)Application["productsList"];
                string[] productsID = Request.Cookies["cart"].Value.Split(',');
                foreach (string productID in productsID)
                {
                    foreach (ProductsList product in productsLists)
                    {
                        if (product.id == productID)
                        {
                            cartList.Add(product);
                        }
                    }
                }

                ListViewCart.DataSource = cartList;
                ListViewCart.DataBind();

                //Display total products

                //Display products price
                int productsPrice = 0;
                foreach (ProductsList product in cartList) productsPrice += Int32.Parse(product.price);
                products_price.InnerHtml = $"{productsPrice} <span class='cart__product-price-unit'>đ</span>";

                //Display delivery price
                const int DELIVERY = 50000;
                delivery_price.InnerHtml = $"{DELIVERY} <span class='cart__product-price-unit'>đ</span>";

                //Display order total price
                int orderTotal = productsPrice + DELIVERY;
                order_total_price.InnerHtml = $"{orderTotal} <span class='cart__product-price-unit'>đ</span>";
            }
        }
    }
}