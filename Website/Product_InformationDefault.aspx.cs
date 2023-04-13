using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Website
{
    public partial class Product_InformationDefault : System.Web.UI.Page
    {
        protected void get_ChiTiet_SanPham(string idSP)
        {

        }
        protected void Page_Load(object sender, EventArgs e)
        {
            string idSanPham = Request.QueryString.Get("id");

            if (idSanPham != null)
            {

                //Dislay page content                
                string pageTitle = "";

                //Display product information

                Utility utility = new Utility();
                DataTable dt = utility.get_ChiTiet_SanPham(idSanPham);
                if (dt.Rows.Count > 0)
                {
                    pageTitle = dt.Rows[0]["sTenSanPham"].ToString();
                }
                ListViewProductInformation1.DataSource = dt;
                ListViewProductInformation1.DataBind();
                ListViewProductInformation2.DataSource = dt;
                ListViewProductInformation2.DataBind();

                //Display product colors
                //List<ProductsList> productColors = new List<ProductsList>();
                ////Get productID without color part, ex: "1.1" -> "1", "12.1" -> "12"
                //string currentProductIDBeforeDot = id.Substring(0, id.Length - 2);
                //foreach (ProductsList product in productsList)
                //{
                //    //Compare with productID without color from list
                //    string productIDBeforeDot = product.id.Substring(0, product.id.Length - 2);
                //    if (currentProductIDBeforeDot == productIDBeforeDot)
                //    {
                //        productColors.Add(product);
                //    }
                //}

                //ListViewProductColors.DataSource = productColors;
                //ListViewProductColors.DataBind();

                //Change Page Title
                Page.Title = pageTitle;
            }
            else
                Response.Redirect("IndexDefault.aspx");
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