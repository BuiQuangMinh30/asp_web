using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Website
{
    public partial class All_ProductsDefault : System.Web.UI.Page
    {
        string con = ConfigurationManager.ConnectionStrings["dbconnection"].ConnectionString;
        protected void getProductsListByType(string idDanhMuc, string Type)
        {
            Utility utility = new Utility();
            DataTable dt = utility.get_SanPham(idDanhMuc);
            Page.Title = "Đồ ăn dành cho " + Type;
            ListViewAllProducts.DataSource = dt;
            ListViewAllProducts.DataBind();
        }

        protected void getProductsListBySearchAndFilter(string search, int begin, int end, List<Product> productsListsBySearchAndFilter, List<Product> productsLists)
        {
            foreach (Product product in productsLists)
            {
                if (product.sTenSanPham.ToLower().IndexOf(search) != -1 && product.fDonGia >= begin && product.fDonGia <= end)
                {
                    productsListsBySearchAndFilter.Add(product);
                }
            }
            ListViewAllProducts.DataSource = productsListsBySearchAndFilter;
            ListViewAllProducts.DataBind();
        }

        protected string totalProducts(List<Product> productsListsByTypeAndFilter)
        {
            int total = 0;
            foreach (Product product in productsListsByTypeAndFilter)
                total++;
            return total.ToString();
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            string idDanhMuc = Request.QueryString.Get("idDanhMuc");
            string sTenDanhMuc = Request.QueryString.Get("type");
            string search = Request.QueryString.Get("searchText");
            string Number1 = Request.QueryString.Get("searchGia_1");
            string Number2 = Request.QueryString.Get("searchGia_2");

            if (idDanhMuc != null)
            {
                getProductsListByType(idDanhMuc, sTenDanhMuc);
            }

            if (idDanhMuc == null && search == null)
            {
                Utility utility = new Utility();
                DataTable dt = utility.getAll_SanPham();
                ListViewAllProducts.DataSource = dt;
                ListViewAllProducts.DataBind();
            }

            if (search != null)
            {
                string searchText = Request.QueryString["searchText"];
                DataTable dt = GetFilteredData(searchText);      //Hàm lấy danh sách sản phẩm từ cơ sở dữ liệu
                string jsonString = ConvertDataTableToJson(dt);  // Hàm chuyển đổi DataTable sang đối tượng JSON
                Response.Clear();
                Response.ContentType = "application/json; charset=utf-8";
                Response.Write(jsonString);
                Response.End();
            }

           

            if (Number1 != null && Number2 != null)
            {
                string Number_1 = Request.QueryString.Get("searchGia_1");
                string Number_2 = Request.QueryString.Get("searchGia_2");
                DataTable dt = GetFilteredMoney(Number_1, Number_2); // Hàm lấy danh sách sản phẩm từ cơ sở dữ liệu
                string jsonString = ConvertDataTableToJson(dt);  // Hàm chuyển đổi DataTable sang đối tượng JSON
                Response.Clear();
                Response.ContentType = "application/json; charset=utf-8";
                Response.Write(jsonString);
                Response.End();
            }

        }
        public DataTable GetFilteredData(string searchText)
        {
            using (SqlConnection conn = new SqlConnection(con))
            {
                //string query = "SELECT * FROM tblSanPham WHERE sTenSanPham LIKE '%' + @searchText + '%'";
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = conn;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = "sp_search_Product";
                    cmd.Parameters.AddWithValue("@sTenSanPham", searchText);
                    using (SqlDataAdapter dataAdapter = new SqlDataAdapter(cmd))
                    {
                        using (DataTable dt = new DataTable())
                        {
                            dataAdapter.Fill(dt);
                            return dt;
                        }
                    }

                }
            }
        }
        public DataTable GetFilteredMoney(string f1, string f2)
        {
            string connString = ConfigurationManager.ConnectionStrings["dbconnection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "SELECT * FROM tblSanPham WHERE fDonGia >= @f1 AND fDonGia <= @f2";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@f1", f1);
                    cmd.Parameters.AddWithValue("@f2", f2);
                    using (SqlDataAdapter dataAdapter = new SqlDataAdapter(cmd))
                    {
                        using (DataTable dt = new DataTable())
                        {
                            dataAdapter.Fill(dt);
                            return dt;
                        }
                    }

                }
            }
        }

        private string ConvertDataTableToJson(DataTable dt)
        {
            string jsonString = JsonConvert.SerializeObject(dt);
            return jsonString;
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            string Number1 = Request.QueryString.Get("Number1");
            string Number2 = Request.QueryString.Get("Number2");

            if (Number1 != null || Number2 != null)
            {
                DataTable dt = GetFilteredMoney(Number1, Number2); // Hàm lấy danh sách sản phẩm từ cơ sở dữ liệu
                string jsonString = ConvertDataTableToJson(dt);  // Hàm chuyển đổi DataTable sang đối tượng JSON
                Response.Clear();
                Response.ContentType = "application/json; charset=utf-8";
                Response.Write(jsonString);
                Response.End();
            }

        }

        
    }
}