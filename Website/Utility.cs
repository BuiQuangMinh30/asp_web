using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Website
{
    public class Utility
    {
        static string cnn = ConfigurationManager.ConnectionStrings["dbconnection"].ConnectionString;
        static SqlConnection con = new SqlConnection(cnn);

        //Check dữ liệu có tồn tại không
        public static bool CheckKey(string sql)
        {
            SqlDataAdapter ad = new SqlDataAdapter(sql, con);
            DataTable tb = new DataTable();
            ad.Fill(tb);
            if (tb.Rows.Count > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        //Lấy ra tất cả Danh mục sản phẩm
        public DataTable getAll_DanhMuc()
        {
           using (SqlCommand cmd = new SqlCommand())
            {
                cmd.Connection = con;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "sp_getAll_DanhMuc";
                using(SqlDataAdapter ad =  new SqlDataAdapter(cmd))
                {
                    using (DataTable dt = new DataTable())
                    {
                        ad.Fill(dt);
                        return dt;
                    }
                }
            } 
        }

        public DataTable getAll_Cart()
        {
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.Connection = con;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "sp_getAll_Cart";
                using (SqlDataAdapter ad = new SqlDataAdapter(cmd))
                {
                    using (DataTable dt = new DataTable())
                    {
                        ad.Fill(dt);
                        return dt;
                    }
                }
            }
        }

        //Update danh mục
        public void update_DanhMuc(int id, string sTenDanhMuc, string sMoTa)
        {
            con.Open();
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.Connection = con;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "sp_updateCategory";
                cmd.Parameters.Add("@sTenDanhMuc", sTenDanhMuc);
                cmd.Parameters.Add("@sMoTa", sMoTa);
                cmd.Parameters.Add("@id", id);
                cmd.ExecuteNonQuery();
                
            }
            con.Close();
        }

        public void update_Cart(int id)
        {
            con.Open();
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.Connection = con;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "sp_updateCart";
                cmd.Parameters.Add("@iTrangThai", 1);
                cmd.Parameters.Add("@id", id);
                cmd.ExecuteNonQuery();

            }
            con.Close();
        }


        //Lấy ra sản phẩm theo danh mục
        public DataTable get_SanPham(string id)
        {
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.Connection = con;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "sp_get_Product";
                cmd.Parameters.Add("@iDanhMucId", id);
                using (SqlDataAdapter ad = new SqlDataAdapter(cmd))
                {
                    using (DataTable dt = new DataTable())
                    {
                        ad.Fill(dt);
                        return dt;
                    }
                }
            }
        }

        //Lấy ra sản phẩm theo danh mục, ten, giat ien
        public DataTable get_select_SanPham(string id)
        {
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.Connection = con;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "sp_search_Product";
                cmd.Parameters.Add("@sTenSanPham", id);
                using (SqlDataAdapter ad = new SqlDataAdapter(cmd))
                {
                    using (DataTable dt = new DataTable())
                    {
                        ad.Fill(dt);
                        return dt;
                    }
                }
            }
        }

        //Lay ra all product
        public DataTable getAll_SanPham()
        {
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.Connection = con;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "sp_get_Product";
                using (SqlDataAdapter ad = new SqlDataAdapter(cmd))
                {
                    using (DataTable dt = new DataTable())
                    {
                        ad.Fill(dt);
                        return dt;
                    }
                }
            }
        }

        //Lấy ra thông tin sản phẩm
        public DataTable get_ChiTiet_SanPham(string id)
        {
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.Connection = con;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "sp_get_ChiTietSP";
                cmd.Parameters.Add("@iSanPhamId", id);
                using (SqlDataAdapter ad = new SqlDataAdapter(cmd))
                {
                    using (DataTable dt = new DataTable())
                    {
                        ad.Fill(dt);
                        return dt;
                    }
                }
            }
        }


        // Lấy ra thông tin order
        public DataTable getAll_Order()
        {
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.Connection = con;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "sp_getAll_Order";
                using (SqlDataAdapter ad = new SqlDataAdapter(cmd))
                {
                    using (DataTable dt = new DataTable())
                    {
                        ad.Fill(dt);
                        return dt;
                    }
                }
            }
        }
    }
}