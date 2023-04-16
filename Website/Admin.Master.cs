using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Website
{
    public partial class Admin : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //check_role();
            string username = Session["username"].ToString();
            lblTenDangNhap.Text = username;
        }

        private void check_role()
        {
            if (Session["login"] == "1")
            {
                if (Convert.ToInt32(Session["role"]) != 0)
                    Response.Redirect("IndexDefault.aspx");
            }
            else
            {
                Response.Redirect("signIn.aspx");
            }
                
        }
    }
}