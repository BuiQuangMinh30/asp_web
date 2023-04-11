using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Website
{
    public partial class index : System.Web.UI.Page
    {
        protected void displayUserInformation()
        {
            //Display user information
            if (Session["login"].ToString() == "1")
            {
                string username = Session["username"].ToString();

                login_status_desktop.InnerHtml = "<li>Hi " + username + "</li>" +
                                                 "<span>|</span>" +
                                                 "<li><a href='signOut.aspx'>Sign Out</a></li>";

                login_status_mobile.InnerHtml = "<li>Hi " + username + "</li>" +
                                                "<li class='signOut-mobile'><a href='signOut.aspx'><img src='./Images/Icons/LogOut.svg' alt=''></a></li>";
            }
        }
        protected void displayCartNumber()
        {
            //Display cart number
            if (Request.Cookies["cart"] != null)
            {
                string[] cartProductsID = Request.Cookies["cart"].Value.Split(',');
                // -1 empty string after last ,
                Cart_Total_Products.InnerText = (cartProductsID.Length - 1).ToString();
                Cart_Total_Products_Mobile.InnerText = (cartProductsID.Length - 1).ToString();
            }
            else
            {
                Cart_Total_Products.InnerText = "0";
                Cart_Total_Products_Mobile.InnerText = "0";
            }  
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            displayUserInformation();
            displayCartNumber();

            //Display slide products
            List<ProductsList> productsLists = (List<ProductsList>)Application["productsList"];
            List<ProductsList> nikeSlideProducts = new List<ProductsList>();
            List<ProductsList> adidasSlideProducts = new List<ProductsList>();
            List<ProductsList> pumaSlideProducts = new List<ProductsList>();
            foreach(ProductsList product in productsLists)
            {
                string id = product.id;
                if(id == "1.1" || id == "2.1" || id == "3.1" || id == "4.1" || id == "5.1" || id == "6.1" || id == "7.1")
                {
                    nikeSlideProducts.Add(product);
                }

                if (id == "21.1" || id == "22.1" || id == "23.1" || id == "24.1" || id == "25.1" || id == "26.1" || id == "27.1" || id == "28.1")
                {
                    adidasSlideProducts.Add(product);
                }

                if (id == "50.1" || id == "51.1" || id == "52.1" || id == "53.1" || id == "54.1" || id == "55.1" || id == "56.1" || id == "57.1" || id == "58.1" || id == "59.1")
                {
                    pumaSlideProducts.Add(product);
                }

            }

            ListViewNikeSlideProducts.DataSource = nikeSlideProducts;
            ListViewNikeSlideProducts.DataBind();

            ListViewAdidasSlideProducts.DataSource = adidasSlideProducts;
            ListViewAdidasSlideProducts.DataBind();

            ListViewPumaSlideProducts.DataSource = pumaSlideProducts;
            ListViewPumaSlideProducts.DataBind();

        }

        protected void SearchButton_Click(object sender, EventArgs e)
        {
            //string searchText = "";

            //if (search_text.Value != "")
            //{
            //    searchText = search_text.Value.ToLower();
            //}
            //else if (search_text_mobile.Value != "")
            //{
            //    searchText = search_text_mobile.Value.ToLower();
            //}
            //Response.Redirect($"all_products.aspx?search={searchText}");
        }
    }
}