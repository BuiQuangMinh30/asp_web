using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Website
{
    public partial class Product_InformationDefault : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string id = Request.QueryString.Get("id");

            if (id != null)
            {

                //Dislay page content                
                string pageTitle = "";

                //Display product information
                List<ProductsList> productsList = (List<ProductsList>)Application["productsList"];
                List<ProductsList> productInformation = new List<ProductsList>();
                foreach (ProductsList product in productsList)
                {
                    if (id == product.id)
                    {
                        productInformation.Add(product);
                        pageTitle = product.name;
                    }
                }

                ListViewProductInformation1.DataSource = productInformation;
                ListViewProductInformation1.DataBind();
                ListViewProductInformation2.DataSource = productInformation;
                ListViewProductInformation2.DataBind();

                //Display product colors
                List<ProductsList> productColors = new List<ProductsList>();
                //Get productID without color part, ex: "1.1" -> "1", "12.1" -> "12"
                string currentProductIDBeforeDot = id.Substring(0, id.Length - 2);
                foreach (ProductsList product in productsList)
                {
                    //Compare with productID without color from list
                    string productIDBeforeDot = product.id.Substring(0, product.id.Length - 2);
                    if (currentProductIDBeforeDot == productIDBeforeDot)
                    {
                        productColors.Add(product);
                    }
                }

                ListViewProductColors.DataSource = productColors;
                ListViewProductColors.DataBind();

                //Change Page Title
                Page.Title = pageTitle;
            }
            else
                Response.Redirect("index.aspx");
        }
        protected void SearchButton_Click(object sender, EventArgs e)
        {
            //    string searchText = "";

            //    if (search_text.Value != "")
            //    {
            //        searchText = search_text.Value.ToLower();
            //    }
            //    else if (search_text_mobile.Value != "")
            //    {
            //        searchText = search_text_mobile.Value.ToLower();
            //    }

            //    Response.Redirect($"all_products.aspx?search={searchText}");
        }

        protected void AddToCartButton_Click(object sender, EventArgs e)
        {
            string id = Request.QueryString.Get("id");

            //Store cart to cookies
            if (Request.Cookies["cart"] == null)
            {
                Response.Cookies["cart"].Value = $"{id},";
                Response.Cookies["cart"].Expires = DateTime.Now.AddDays(14);
            }
            else
            {
                //Store cookies by productID, example: 1,2,3,40,50,... 
                Response.Cookies["cart"].Value = Request.Cookies["cart"].Value + $"{id},";
                Response.Cookies["cart"].Expires = DateTime.Now.AddDays(14);
            }

            //Refresh to update cart number
            Response.Redirect(Request.Url.ToString());
        }
    }
}