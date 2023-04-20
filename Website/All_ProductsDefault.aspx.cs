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
        protected void getProductsListByTypeAndFilter(string idDanhMuc, string Type)
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

            if (idDanhMuc != null)
            {
                getProductsListByTypeAndFilter(idDanhMuc, sTenDanhMuc);
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
                DataTable dt = GetFilteredData(searchText); // Hàm lấy danh sách sản phẩm từ cơ sở dữ liệu
                string jsonString = ConvertDataTableToJson(dt);  // Hàm chuyển đổi DataTable sang đối tượng JSON
                Response.Clear();
                Response.ContentType = "application/json; charset=utf-8";
                Response.Write(jsonString);
                Response.End();
            }

        }
        public DataTable GetFilteredData(string searchText)
        {
            string connString = ConfigurationManager.ConnectionStrings["dbconnection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "SELECT * FROM tblSanPham WHERE sTenSanPham LIKE '%' + @searchText + '%'";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@searchText", searchText);
                    using(SqlDataAdapter dataAdapter = new SqlDataAdapter(cmd))
                    {
                        using(DataTable dt = new DataTable())
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
    }
}