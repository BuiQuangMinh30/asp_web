﻿using System;
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
    public partial class FormCart : System.Web.UI.Page
    {
        string con = ConfigurationManager.ConnectionStrings["dbconnection"].ConnectionString;
        float productsPrice = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            Utility utility = new Utility();

            //========= Display page content==============
            List<Product> productsLists = new List<Product>();
            DataTable dataTable = utility.getAll_SanPham();

            foreach (DataRow row in dataTable.Rows)
            {
                Product product = new Product();
                product.idSanPham = (int)row["iSanPhamId"];
                product.sTenSanPham = row["sTenSanPham"].ToString();
                product.sMoTa = row["sMoTa"].ToString();
                product.sAnh = row["sAnh"].ToString();
                product.fDonGia = (float)Convert.ToDouble(row["fDonGia"]);
                product.dThoiGianTao = (DateTime)row["dThoiGianTao"];
                product.idDanhmuc = (int)row["iDanhMucId"];
                productsLists.Add(product);
            }

            //Display products
            if (Request.Cookies["cart"] != null)
            {

                //Display product information
                List<Product> cartList = new List<Product>();
                string[] productsID = Request.Cookies["cart"].Value.Split(',');
                foreach (string productID in productsID)
                {
                    foreach (Product product in productsLists)
                    {
                        if (product.idSanPham.ToString() == productID)
                        {
                            //Product pItem = new Product();
                            //pItem.idSanPham = product.idSanPham;
                            //pItem.sTenSanPham = product.sTenSanPham;
                            //pItem.sMoTa = product.sMoTa;
                            //pItem.sAnh = product.sAnh;
                            //pItem.fDonGia = (float)Convert.ToDouble(product.fDonGia);
                            //pItem.dThoiGianTao = product.dThoiGianTao;
                            //pItem.idDanhmuc = product.idDanhmuc;
                            //pItem.iSoLuong = 1;
                            //cartList.Add(pItem);
                            cartList.Add(product);
                        }
                    }
                }
                foreach (Product cartItem in cartList) 
                { 
                    productsPrice += cartItem.fDonGia; 
                }
                
            }
        }
        public List<Product> GetCartItems()
        {
            Utility utility = new Utility();

            //========= Display page content==============
            List<Product> productsLists = new List<Product>();
            DataTable dataTable = utility.getAll_SanPham();

            foreach (DataRow row in dataTable.Rows)
            {
                Product product = new Product();
                product.idSanPham = (int)row["iSanPhamId"];
                product.sTenSanPham = row["sTenSanPham"].ToString();
                product.sMoTa = row["sMoTa"].ToString();
                product.sAnh = row["sAnh"].ToString();
                product.fDonGia = (float)Convert.ToDouble(row["fDonGia"]);
                product.dThoiGianTao = (DateTime)row["dThoiGianTao"];
                product.idDanhmuc = (int)row["iDanhMucId"];
                productsLists.Add(product);
            }

            List<Product> cartList = new List<Product>();

            //Display products
            if (Request.Cookies["cart"] != null)
            {

                string[] productsID = Request.Cookies["cart"].Value.Split(',');
                foreach (string productID in productsID)
                {
                    foreach (Product product in productsLists)
                    {
                        if (product.idSanPham.ToString() == productID)
                        {
                            cartList.Add(product);
                        }
                    }
                }

            }
            return cartList;
        }


        protected void btnAdd_Product_Click(object sender, EventArgs e)
        {
            string sTenkhachhang = Request.Form.Get("name");
            string sEmail = Request.Form.Get("email");
            string sPhone = Request.Form.Get("phone");
            string address = Request.Form.Get("address");
            var orderDate = DateTime.UtcNow;

            using (SqlConnection conn = new SqlConnection(con))
            {
                using (SqlCommand cmd = new SqlCommand("INSERT INTO tblDonHang (iKhachHangId, sTenKhachHang, sEmail, sPhuongThucThanhToan, sPhone, sDiaChiGiao,dNgayDat,fTongTien, iTrangThai) " +
                    "VALUES (@iKhachHangId, @sTenKhachHang, @sEmail, @sPhuongThucThanhToan, @sPhone, @sDiaChiGiao,@dNgayDat,@fTongTien,@iTrangThai); SELECT SCOPE_IDENTITY()", conn))
                {

                    cmd.Connection = conn;
                    cmd.Parameters.AddWithValue("@iKhachHangId", 5);
                    cmd.Parameters.AddWithValue("@sTenKhachHang", sTenkhachhang.ToString());
                    cmd.Parameters.AddWithValue("@sEmail", sEmail.ToString());
                    cmd.Parameters.AddWithValue("@sPhuongThucThanhToan", 1);
                    cmd.Parameters.AddWithValue("@sPhone", sPhone.ToString());
                    cmd.Parameters.AddWithValue("@sDiaChiGiao", address.ToString());
                    cmd.Parameters.AddWithValue("@dNgayDat", orderDate);
                    cmd.Parameters.AddWithValue("@fTongTien", Convert.ToDouble(productsPrice));
                    cmd.Parameters.AddWithValue("@iTrangThai", 1);

                    conn.Open();
                    var orderId = (int)(decimal)cmd.ExecuteScalar();


                    var cartItems = GetCartItems();
                    foreach (var cartItem in cartItems)
                    {
                        var orderItemCommand = new SqlCommand("INSERT INTO tblChiTietDonHang ( iDonHangId,iSanPhamId, iSoluong, fDonGia) VALUES (@iDonHangId, @iSanPhamId, @iSoluong, @fDonGia)", conn);

                        orderItemCommand.Parameters.AddWithValue("@iDonHangId", orderId);
                        orderItemCommand.Parameters.AddWithValue("@iSanPhamId", cartItem.idSanPham);
                        orderItemCommand.Parameters.AddWithValue("@iSoluong", 1);
                        orderItemCommand.Parameters.AddWithValue("@fDonGia", cartItem.fDonGia);

                        orderItemCommand.ExecuteNonQuery();
                    }
                }
            }
        }
    }
}