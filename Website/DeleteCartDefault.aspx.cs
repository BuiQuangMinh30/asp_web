﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Website
{
    public partial class DeleteCartDefault : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string deletedProductID = Request.QueryString.Get("id");
            string deletedProductIDInCookies = deletedProductID + ",";
            string cartCookies = Request.Cookies["cart"].Value;
            int deletedProductIDPositionInCookies = cartCookies.IndexOf(deletedProductID);
            //Xóa đi theo vị trí, và id xóa
            string newCookiesAfterDeletedProduct = cartCookies.Remove(deletedProductIDPositionInCookies, deletedProductIDInCookies.Length);

            Response.Cookies["cart"].Value = newCookiesAfterDeletedProduct;
            Response.Cookies["cart"].Expires = DateTime.Now.AddDays(12);
            Response.Redirect("CartDefault.aspx");
        }
    }
}