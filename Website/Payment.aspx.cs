using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Website
{
    public partial class Payment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                List<CartItem> cartItems = (List<CartItem>)Session["CartItems"];

                if (cartItems == null)
                {
                    cartItems = new List<CartItem>();
                }
                string[] keys = Request.Form.AllKeys;
                foreach (string key in keys)
                {
                    string value = Request.Form[key];
                    // xử lý dữ liệu tại đây
                    CartItem i = new CartItem();
                    i.iSoluong = value;
                    cartItems.Add(i);
                }
                Session["CartItems"] = cartItems;
            }
           
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            List<CartItem> cartItems = (List<CartItem>)Session["CartItems"];
        }
    }
}