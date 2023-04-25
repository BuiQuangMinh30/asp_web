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
    public partial class AdminEditProduct : System.Web.UI.Page
    {
        string cnn = ConfigurationManager.ConnectionStrings["dbconnection"].ConnectionString;
        private int selectedIdDanhMuc;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Utility utility = new Utility();
                DataTable tb = utility.getAll_DanhMuc();
                ListView1.DataSource = tb;
                ListView1.DataBind();
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            //Request Form thì không được thêm runnat
            int id = Convert.ToInt32(Request.QueryString["id"]); 
            string idDanhMuc = Request.Form.Get("categoryName");
            string sTenSanPham = Request.Form.Get("productName");
            string moTa = Request.Form.Get("productDesc");
            string donGia = Request.Form.Get("productPrice");
            using (SqlConnection connection = new SqlConnection(cnn))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = connection;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "sp_updateProduct";
                    cmd.Parameters.Add("@sTenSanPham", sTenSanPham);
                    cmd.Parameters.Add("@iDanhMucId",Convert.ToInt32(idDanhMuc));
                    cmd.Parameters.Add("@fDonGia", (float)Convert.ToDouble(donGia));
                    cmd.Parameters.Add("@sMoTa", moTa);
                    if (FileUpload1.FileName != "")
                    {
                        FileUpload1.PostedFile.SaveAs(Server.MapPath("~/Images") + @"\" + FileUpload1.FileName);
                        cmd.Parameters.AddWithValue("@sAnh", "./Images/" + FileUpload1.FileName);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@sAnh", "./Images/blank.png");
                    }
                    cmd.Parameters.Add("@id", id);

                    connection.Open();
                    int result = cmd.ExecuteNonQuery();
                    if (result > 0)
                    {
                        Response.Redirect("AdminProductList.aspx");
                    }
                    connection.Close();
                    cmd.Dispose();
                }
            }
           

        }
    }
}