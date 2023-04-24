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
    public partial class AdminListCart : System.Web.UI.Page
    {
        string con = ConfigurationManager.ConnectionStrings["dbconnection"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            get_DanhMuc();
            if (Request["id"] != null)
            {
                Response.Clear();
                btnChangeTrangThai(Convert.ToInt32(Request.QueryString["id"]));
                Response.Flush();
                Response.End();
            }
        }
        //public string ConvertNumberToThanhToan(string text)
        //{
        //    if (text == "1" || text == "ck")
        //    {
        //        return "Thanh toán chuyển khoản";
        //    }
        //    else if (text == "0")
        //    {
        //        return "Thanh toán trực tiếp";
        //    }
        //    else
        //    {
        //        return "Không rõ";
        //    }
        //}
        public string ConvertNumberToWord(int number)
        {
            if (number == 1)
            {
                return "Giao hàng thành công";
            }
            else if (number == 0)
            {
                return "Chưa hoàn thành";
            }
            else
            {
                return "Không rõ";
            }
        }

       

        protected void get_DanhMuc()
        {
            Utility utility = new Utility();
            DataTable tb = utility.getAll_Order();
            listProduct.DataSource = tb;
            listProduct.DataBind();
        }

        private void btnChangeTrangThai(int id)
        {
            using (SqlConnection cnn = new SqlConnection(con))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = cnn;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "sp_updateCart";
                    cmd.Parameters.Add("@iDonHangId", id);
                    cmd.Parameters.Add("@iTrangThai", 1);
                    cnn.Open();
                    cmd.ExecuteNonQuery();
                    cnn.Close();
                }
            }
        }
    }
}