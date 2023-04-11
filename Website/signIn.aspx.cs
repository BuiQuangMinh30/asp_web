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
    public partial class signIn : System.Web.UI.Page
    {
        public static string strconn = ConfigurationManager.ConnectionStrings["dbconnection"].ConnectionString;
        protected void redirectIfLoggedIn()
        {
            if (Session["login"].ToString() == "1")
                Response.Redirect("index.aspx");
        }
        protected void displayUserInformation()
        {
            //Display user information
            if (Session["login"].ToString() == "1")
            {
                string username = Session["username"].ToString();

                login_status_desktop.InnerHtml = "<li>Xin chào " + username + "</li>" +
                                                 "<span>|</span>" +
                                                 "<li><a href='signOut.aspx'>Sign Out</a></li>";

                login_status_mobile.InnerHtml = "<li>Hi " + username + "</li>" +
                                                "<li class='signOut-mobile'><a href='signOut.aspx'><img src='./Images/Icons/LogOut.svg' alt=''></a></li>";
            }
        }
        protected void displayCartNumber()
        {
            //Display cart number
            if (Request.Cookies["cart"] != null)
            {
                string[] cartProductsID = Request.Cookies["cart"].Value.Split(',');
                // -1 empty string after last ,
                Cart_Total_Products.InnerText = (cartProductsID.Length - 1).ToString();
                Cart_Total_Products_Mobile.InnerText = (cartProductsID.Length - 1).ToString();
            }
            else
            {
                Cart_Total_Products.InnerText = "0";
                Cart_Total_Products_Mobile.InnerText = "0";
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            redirectIfLoggedIn();
            displayUserInformation();
            displayCartNumber();

            if (IsPostBack)
            {
                //string username = Request.Form.Get("input-username");
                //string password = Request.Form.Get("input-password");
                //List<User> arr = (List<User>)Application["user"];

                //if(arr.Count == 0)
                //{
                //    sign_in_status.InnerHtml = "Tài khoản không tồn tại";
                //}
                //else
                //{
                //    foreach(User user in arr)
                //    {
                //        if (user.username == username && user.password == password)
                //        {
                //            Session["login"] = 1;
                //            Session["username"] = username;
                //            break;
                //        }
                //        else
                //        {
                //            if (user.username != username && user.password == password)
                //                username_message.InnerHtml = "Sai tài khoản";
                //            if (user.username == username && user.password != password)
                //                password_message.InnerHtml = "Sai mật khẩu";
                //            if (user.username != username && user.password != password)
                //            {
                //                username_message.InnerHtml = "Sai tài khoản";
                //                password_message.InnerHtml = "Sai mật khẩu";
                //            }
                //        }
                //    }

                //    if ((int)Session["login"] == 1)
                //    {
                //        Response.Redirect("index.aspx");
                //    }
                //}
            }
        }
        protected void SearchButton_Click(object sender, EventArgs e)
        {
        //    string searchText = "";

        //    if (search_text.Value != "")
        //    {
        //        searchText = search_text.Value.ToLower();
        //    }
        //    else if (search_text_mobile.Value != "")
        //    {
        //        searchText = search_text_mobile.Value.ToLower();
        //    }

        //    Response.Redirect($"all_products.aspx?search={searchText}");
        }

        protected void btndangnhap_Click(object sender, EventArgs e)
        {
            string username = txtTaiKhoan.Value.Trim();
            string password = txtMatKhau.Value.Trim();
            using (SqlConnection cnn = new SqlConnection(strconn))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = cnn;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "sp_dangNhap";
                    cmd.Parameters.AddWithValue("@sEmail", username);
                    cmd.Parameters.AddWithValue("@sMatKhau", password);
                    cnn.Open();
                    cmd.ExecuteNonQuery();
                    SqlDataReader dr;
                    dr = cmd.ExecuteReader();
                    if (dr.Read())
                    {
                        Session["login"] = "1";
                        Session["username"] = dr["sHoTen"].ToString();
                        Session["role"] = Convert.ToInt32(dr["sRole"].ToString());
                        Session["id"] = Convert.ToInt32(dr["iKhachHangId"].ToString());
                        cnn.Close();
                        if (Convert.ToInt32(Session["role"]) == 0)
                        {
                            //Response.Redirect("Admin.aspx");
                        }
                        else
                        {
                            Response.Redirect("IndexDefault.aspx");
                        }
                    }
                    else
                    {
                        sign_in_status.InnerText = "Nhập sai tài khoản hoặc mật khẩu";
                    }
                }
            }
        }
        //protected void date(object sender, EventArgs e)
        //{
        //    string date = DateTime.UtcNow.ToString("d");
        //    Console.WriteLine("Thoi gian hien tai la {0}", date);
        //}
    }
}