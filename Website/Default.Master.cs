using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Website
{
    public partial class Default : System.Web.UI.MasterPage
    {
        protected void displayUserInformation()
        {
            //Display user information
            if (Session["login"].ToString() == "1")
            {
                string username = Session["username"].ToString();

                login_status_desktop.InnerHtml = "<li>Xin chào " + username + "</li>" +
                                                 "<span>|</span>" +
                                                 "<li><a href='signOut.aspx'>Sign Out</a></li>";

                login_status_mobile.InnerHtml = "<li>Xin chào " + username + "</li>" +
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

        }
    }
}