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
    public partial class CartForm : System.Web.UI.Page
    {
        string con = ConfigurationManager.ConnectionStrings["dbconnection"].ConnectionString;
        
        float productsPrice = 0;
            
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (Session["login"] == "0")
            //{
            //    Response.Redirect("signIn.aspx");
            //}
            List<ProductsList> cartList = new List<ProductsList>();
            foreach (ProductsList product1 in cartList) productsPrice += product1.fDonGia;
        }

        protected void btnAdd_Cart_Click(object sender, EventArgs e)
        {
            string sTenKhachHang = Request.Form.Get("name");
            string sEmail = Request.Form.Get("email");
            string sPhone = Request.Form.Get("phone");
            string sDiaChiGiao = Request.Form.Get("address");
           
            

            using (SqlConnection cnn = new SqlConnection(con))
            {
                cnn.Open();
                SqlTransaction transaction = cnn.BeginTransaction();
                int id = 0;
                using (SqlCommand cmd = new SqlCommand())
                {
                   
                    cmd.Connection = cnn;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "sp_order_Cart";
                    cmd.Parameters.Add("@iKhachHangId", 4);
                    cmd.Parameters.Add("@sTenKhachHang", sTenKhachHang.ToString());
                    cmd.Parameters.Add("@sEmail", sEmail.ToString());
                    cmd.Parameters.Add("@sPhuongThucThanhToan","ck");
                    cmd.Parameters.Add("@sPhone", sPhone.ToString());
                    cmd.Parameters.Add("@sDiaChiGiao", sDiaChiGiao.ToString());
                    cmd.Parameters.AddWithValue("@dNgayDat", DateTime.Now);
                    cmd.Parameters.Add("@fTongTien", productsPrice.ToString());
                    cmd.Parameters.Add("@iTrangThai", 1);
                    SqlParameter outputParam = new SqlParameter("@iDonHangId", SqlDbType.Int)
                    {
                        Direction = ParameterDirection.Output
                    };
                    cmd.Parameters.Add(outputParam);
                   

                    //int exec = cmd.ExecuteNonQuery();
                    //if (exec > 0)
                    //{
                        //if(param.Value != DBNull.Value)
                        //{
                        id = Convert.ToInt32(outputParam.Value);
                        Response.Write("One: " + id + "<br/>");
                        //}
                        transaction.Commit();
                    //}
                    cnn.Close();
                    cmd.Dispose();
                }
            }
        }
    }
}