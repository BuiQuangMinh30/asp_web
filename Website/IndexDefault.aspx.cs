using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Website
{
    public partial class IndexDefault : System.Web.UI.Page
    {
        public static string strconn = ConfigurationManager.ConnectionStrings["dbconnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
         
            SqlDataAdapter sda = new SqlDataAdapter("Select *from tblSanPham", strconn);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            ListView2.DataSource = dt;
            ListView2.DataBind();
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