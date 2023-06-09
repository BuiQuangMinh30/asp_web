﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace Website
{
    public partial class signUp : System.Web.UI.Page
    {
        string con = ConfigurationManager.ConnectionStrings["dbconnection"].ConnectionString.ToString();
        protected void displayUserInformation()
        {
            //Display user information
            if (Session["login"].ToString() == "1")
            {
                string username = Session["username"].ToString();

                login_status_desktop.InnerHtml = "<li>Hi " + username + "</li>" +
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

        public bool containsNumber(string test)
        {
            if (test != "")
            {
                return test.Any(char.IsDigit);
            }
            return false;
        }

        public bool containsWhiteSpace(string test)
        {
            if (test != "")
            {
                return test.Any(char.IsWhiteSpace);
            }
            return false;
        }

        public int emailCheck(string test)
        {
            int countAtSign()
            {
                int count = 0;
                foreach (char c in test)
                {
                    if (c == '@')
                        count++;
                }
                return count;
            }

            if (test != "")
            {
                if (test.IndexOf(".") == -1 && test.IndexOf("@") == -1)
                    return -1;
                else if (test.IndexOf("@") == -1)
                    return -2;
                else if (test.IndexOf(".") == -1)
                    return -3;
                else if (countAtSign() > 1)
                    return -4;
                else if (test.IndexOf("@") == 0)
                    return -5;
                else if (test.IndexOf(".", test.IndexOf("@")) - test.IndexOf("@") <= 2)
                    return -6;
            }
            return 0;
        }

        public bool isValid(string fullname, string address, string phone, string email, string password, string repassword)
        {
            bool check = false;
            int pass = 0;

            if (!check)
            {
                if (pass != 6)
                {
                    //Fullname check
                    if (fullname == "")
                        fullname_message.InnerHtml = "Hãy nhập họ và tên";
                    else if (containsNumber(fullname))
                        fullname_message.InnerHtml = "Họ và tên không được chứa số";
                    else
                    {

                        fullname_message.InnerHtml = "";
                        pass++;
                    }

                    //Email check
                    if (email == "")
                        email_message.InnerHtml = "Hãy nhập Email";
                    else if (emailCheck(email) == -1)
                        email_message.InnerHtml = "Email phải chứa '@' và '.'";
                    else if (emailCheck(email) == -2)
                        email_message.InnerHtml = "Email phải chứa '@'";
                    else if (emailCheck(email) == -3)
                        email_message.InnerHtml = "Email phải chứa '.'";
                    else if (emailCheck(email) == -4)
                        email_message.InnerHtml = "Email không được có nhiều hơn 1 '@'";
                    else if (emailCheck(email) == -5)
                        email_message.InnerHtml = "Email phải có ít nhất 1 ký tự trước '@'";
                    else if (emailCheck(email) == -6)
                        email_message.InnerHtml = "Phải có ít nhất 2 ký tự giữa '@' và '.'";
                    else
                    {
                        string sql = "select * from tblKhachHang where sEmail = N'"+email+"'";
                        if (Utility.CheckKey(sql))
                        {
                            sign_up_status.InnerHtml = "";
                            email_message.InnerHtml = "Email này đã có người sử dụng";
                        }
                        else
                        {
                            email_message.InnerHtml = "";
                            pass++;
                        }
                    }

                    //Address check
                    if (address == "")
                    {
                        address_message.InnerHtml = "Hãy nhập địa chỉ";
                    }    
                    else
                    {
                        address_message.InnerHtml = "";
                        pass++;
                    }

                    //Phone check
                    if (phone == "")
                    {
                        phone_message.InnerHtml = "Hãy nhập số điện thoại";
                    }
                    else
                    {
                        phone_message.InnerHtml = "";
                        pass++;
                    }

                    //Password check
                    if (password == "")
                        password_message.InnerHtml = "Hãy nhập mật khẩu";
                    else if (password.Length <= 5)
                        password_message.InnerHtml = "Mật khẩu phải lớn hơn 5 ký tự";
                    else
                    {
                        password_message.InnerHtml = "";
                        pass++;
                    }

                    //Repassword check
                    if (repassword == "")
                        repassword_message.InnerHtml = "Hãy nhập lại mật khẩu";
                    else if (repassword != password)
                        repassword_message.InnerHtml = "Mật khẩu xác nhận không chính xác";
                    else
                    {
                        repassword_message.InnerHtml = "";
                        pass++;
                    }
                }

                if (pass == 6)
                {
                    check = true;
                }
            }

            if (check)
            {
                sign_up_status.InnerHtml = "Đăng kí thành công";
            }
            return check;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            displayUserInformation();
            displayCartNumber();

            //if (IsPostBack)
            //{
            //    string fullname = Request.Form.Get("input-fullname");
            //    string address = Request.Form.Get("input-address");
            //    string phone = Request.Form.Get("input-phone");
            //    string email = Request.Form.Get("input-email");
            //    string password = Request.Form.Get("input-password");
            //    string repassword = Request.Form.Get("input-repassword");

            //    isValid(fullname, address, phone, email, password, repassword);
            //}
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
        protected void btndangky_Click(object sender, EventArgs e)
        {
            string fullname = Request.Form.Get("input-fullname");
            string address = Request.Form.Get("input-address");
            string phone = Request.Form.Get("input-phone");
            string email = Request.Form.Get("input-email");
            string password = Request.Form.Get("input-password");
            string repassword = Request.Form.Get("input-repassword");
            string sql = "select * from tblKhachHang where sEmail = N'" + email + "'";
            if (Utility.CheckKey(sql))
            {
                sign_up_status.InnerHtml = "";
                email_message.InnerHtml = "Email này đã có người sử dụng";
            }
            else
            {
                //if(isValid(fullname, address, phone, email, password, repassword))
                //{
                using (SqlConnection cnn = new SqlConnection(con))
                {
                    using (SqlCommand cmd = cnn.CreateCommand())
                    {
                        cmd.Connection = cnn;
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.CommandText = "sp_dangKy";
                        cmd.Parameters.Add("@sHoTen", fullname);
                        cmd.Parameters.Add("@sEmail", email);
                        cmd.Parameters.Add("@sMatKhau", password);
                        cmd.Parameters.Add("@sDiaChi", address);
                        cmd.Parameters.Add("@sDienThoai", phone);

                        cnn.Open();
                        int kq = cmd.ExecuteNonQuery();
                        if (kq > 0)
                        {
                            sign_up_status.InnerHtml = "Đăng kí thành công";
                            //Response.Redirect("signIn.aspx");
                        }
                    }
                }
                //}
            }

        }
    }
}