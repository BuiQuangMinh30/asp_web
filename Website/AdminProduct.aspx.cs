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
    public partial class AdminProducts : System.Web.UI.Page
    {
        Utility utility = new Utility();
        string con = ConfigurationManager.ConnectionStrings["dbconnection"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            get_DanhMuc();
        }

        protected void get_DanhMuc()
        {
            DataTable tb = utility.getAll_DanhMuc();
            lvDanhMuc.DataSource = tb;
            lvDanhMuc.DataBind();
        }

        protected void btnAdd_Product_Click(object sender, EventArgs e)
        {
            string sTenSanPham = Request.Form.Get("product_name");
            string sMoTa = Request.Form.Get("product_desc");
            string idDanhMuc = Request.Form.Get("cartegory_id");
            string donGia = Request.Form.Get("product_price");

            using (SqlConnection cnn = new SqlConnection(con))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = cnn;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "update_SanPham";
                    cmd.Parameters.Add("@sTenSanPham", sTenSanPham.ToString());
                    cmd.Parameters.Add("@iDanhMucId",Convert.ToInt32(idDanhMuc));
                    cmd.Parameters.Add("@fDonGia", Convert.ToDouble(donGia));
                    cmd.Parameters.Add("@sMoTa", sMoTa);
                    if (FileUpload1.FileName != "")
                    {
                        FileUpload1.PostedFile.SaveAs(Server.MapPath("~/Images") + @"\" + FileUpload1.FileName);
                        cmd.Parameters.AddWithValue("@sAnh", "./Images/" + FileUpload1.FileName);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@sAnh", "Images/blank.png");
                    }
                    cnn.Open();
                    int exec = cmd.ExecuteNonQuery();
                    if (exec > 0)
                    {
                        Response.Redirect("AdminProductList.aspx");
                    }
                    cnn.Close();
                    cmd.Dispose();
                }
            }
            
        }
    }
}