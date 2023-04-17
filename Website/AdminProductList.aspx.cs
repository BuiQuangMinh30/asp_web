using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

namespace Website
{
    public partial class AdminProductList : System.Web.UI.Page
    {
        string con = ConfigurationManager.ConnectionStrings["dbconnection"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            get_ListProduct();
            if (Request["id"] != null)
            {
                Response.Clear();
                btnXoa(Convert.ToInt32(Request.QueryString["id"]));
                Response.Flush();
                Response.End();
            }
        }

        protected void get_ListProduct()
        {
           using (SqlConnection cnn = new SqlConnection(con))
            {
                using(SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = cnn;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "sp_listProduct";
                    using(SqlDataAdapter ad= new SqlDataAdapter(cmd))
                    {
                        using(DataTable tb = new DataTable())
                        {
                            ad.Fill(tb);
                            listProduct.DataSource = tb;
                            listProduct.DataBind();
                        }
                    }
                }
            }
        }

        private void btnXoa(int id)
        {
            using (SqlConnection cnn = new SqlConnection(con))
            {
                using(SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = cnn;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "sp_deleteProduct";
                    cmd.Parameters.Add("@iSanPhamId", id);
                    cnn.Open();
                    cmd.ExecuteNonQuery();
                    cnn.Close();
                }
            }
        }
    }
}