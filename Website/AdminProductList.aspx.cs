using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Services;
using System.IO;
using System.Web.Script.Serialization;
using Newtonsoft.Json;

namespace Website
{
    public partial class AdminProductList : System.Web.UI.Page
    {
        string con = ConfigurationManager.ConnectionStrings["dbconnection"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            Utility utility = new Utility();
            ListView1.DataSource = utility.getAll_DanhMuc();
            ListView1.DataBind();
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
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = cnn;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "sp_listProduct";
                    using (SqlDataAdapter ad = new SqlDataAdapter(cmd))
                    {
                        using (DataTable tb = new DataTable())
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
                using (SqlCommand cmd = new SqlCommand())
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
        public int suaSanPham2(int id, int idCate, string name, string desc, float price, HttpPostedFile img)
        {
            int exec = 0;
            using (SqlConnection cnn = new SqlConnection(con))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = cnn;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "sp_updateProduct";
                    cmd.Parameters.Add("@sTenSanPham", name);
                    cmd.Parameters.Add("@iDanhMucId", idCate);
                    cmd.Parameters.Add("@fDonGia", price);
                    cmd.Parameters.Add("@sMoTa", desc);
                    cmd.Parameters.Add("@id", id);
                    if (img.FileName != null)
                    {
                        img.SaveAs(Server.MapPath("~/Images") + @"\" + img.FileName);
                        cmd.Parameters.AddWithValue("@sAnh", "./Images/" + img.FileName);
                        cmd.Parameters.Add("@sAnh", img);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@sAnh", "Images/blank.png");
                    }
                    cnn.Open();
                    exec = cmd.ExecuteNonQuery();
                    cnn.Close();
                    cmd.Dispose();
                }
            }
            return exec;
        }

        [WebMethod]
        public static string suaSanPham(int id, int idCate, string nameCate, string name, string desc, float price, string img)
        {
            string kq = "";
         
            try
            {
                Utility utility = new Utility();               
                int rs = utility.update_SanPham(id, idCate, name, desc, price, "./Images/" + img);
                if (rs > 0)
                {
                    kq = "Cập nhập thành công";
                }
                else
                {
                    kq = "Cập nhập thất bại";
                }
            }
            catch (Exception ex)
            {
                kq = "Lỗi" + ex.Message;
            }
            return kq;
        }
        public class FileUploadModel
        {
            public string FileName { get; set; }
            public string FileContent { get; set; }
        }
    }
}