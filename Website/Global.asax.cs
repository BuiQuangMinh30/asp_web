using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;

namespace Website
{
    public class Global : System.Web.HttpApplication
    {
        protected void Application_Start(object sender, EventArgs e)
        {
            Application["TotalVisitors"] = 0;
        }

        protected void Session_Start(object sender, EventArgs e)
        {
            Session["login"] = "0";
            Session["role"] = "3";    /*0: admin; 1: khấch hàng*/
            Session["username"] = ""; /*Ten dang nhap*/
            Session["id"] = "0";      /*ID user*/

            Session["pass"] = "";
        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {
            Application["TotalVisitors"] = (int)Application["TotalVisitors"] + 1;
        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}