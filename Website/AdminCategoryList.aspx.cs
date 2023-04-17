using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using Newtonsoft.Json;

namespace Website
{
	public partial class AdminCategoryList : System.Web.UI.Page
	{
		string con = ConfigurationManager.ConnectionStrings["dbconnection"].ConnectionString;
		protected void Page_Load(object sender, EventArgs e)
		{
			int id = Convert.ToInt32(Request.QueryString["id"]);
			getAll_DanhMuc();
			//if (Request.HttpMethod == "POST")
			//{
			//  //Khi phân trang cũng sẽ post nên sẽ chạy vào đây
			//	xoaDanhMuc(id);
			//}
			if (Request["id"] != null)
            {
				xoaDanhMuc(id);
            }
		}

		private void xoaDanhMuc(int id)
        {
			//Kiểm tra danh mục có tồn tại trong bảng sản phẩm chưa
			int count = 0;
			using (SqlConnection conn = new SqlConnection(con))
			{
				conn.Open();
				using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM tblSanPham WHERE iDanhMucId = @idDanhMucId", conn))
				{
					cmd.Parameters.AddWithValue("@idDanhMucId", id);

					//Trả về giá trị đầu tiên trong kết quả
					count = (int)cmd.ExecuteScalar();
				}
				conn.Close();
			}

			if (count > 0)
			{
				Response.Write("exists");
			}
			else
			{
				using (SqlConnection conn = new SqlConnection(con))
				{
					conn.Open();
					using (SqlCommand cmd = new SqlCommand())
					{
						cmd.Connection = conn;
						cmd.CommandType = CommandType.StoredProcedure;
						cmd.CommandText = "sp_deleteCategory";
						cmd.Parameters.AddWithValue("@iDanhMucId", id);
						cmd.ExecuteNonQuery();
					}
					conn.Close();
				}
				Response.Write("success");
			}
			// Kết thúc yêu cầu HTTP POST
			Response.Flush();
			Response.End();
		}

		protected void getAll_DanhMuc()
		{
			Utility utility = new Utility();
			DataTable tb = utility.getAll_DanhMuc();
			listDanhMuc.DataSource = tb;
			listDanhMuc.DataBind();
		}
	}
}