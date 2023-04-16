using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

namespace Website
{
    public partial class CategoryAdmin : System.Web.UI.Page
    {
        string con = ConfigurationManager.ConnectionStrings["dbconnection"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (Session["login"] == "0")
            //{
            //    Response.Redirect("signIn.aspx");
            //}
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            string sTenDanhMuc = Request.Form.Get("category_name");
            string sMoTa = Request.Form.Get("category_description");

            if(sTenDanhMuc.Trim()!="" && sMoTa.Trim()!="")
            {
                using (SqlConnection cnn = new SqlConnection(con))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        cmd.Connection = cnn;
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.CommandText = "sp_add_DanhMuc";
                        cmd.Parameters.Add("@sTenDanhMuc", sTenDanhMuc.ToString());
                        cmd.Parameters.Add("@sMoTa", sMoTa);
                        cmd.Parameters.Add("@id_DM", SqlDbType.Int).Direction = ParameterDirection.Output;
                        cnn.Open();
                        int exec = cmd.ExecuteNonQuery();
                        int id_DM = (int)cmd.Parameters["@id_DM"].Value;
                        if (exec > 0)
                        {
                            Response.Redirect("AdminCategoryList.aspx");
                        }
                        cnn.Close();
                        cmd.Dispose();
                    }
                }
            }
           
        }
    }
}