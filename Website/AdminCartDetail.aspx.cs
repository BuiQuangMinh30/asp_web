using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Website
{
    public partial class AdminCartDetail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string idSanPham = Request.QueryString.Get("id");

            if (idSanPham != null)
            {

                //Dislay page content                
                string pageTitle = "";

                //Display product information

                Utility utility = new Utility();

                //========= Display page content==============
                List<CartDetail> productsLists = new List<CartDetail>();
                DataTable dataTable = utility.getAll_Cart();

                foreach (DataRow row in dataTable.Rows)
                {
                    CartDetail product = new CartDetail();
                    product.iChiTietDonHangId = (int)row["iChiTietDonHangId"];
                    product.iDonHangId = (int)row["iDonHangId"];
                    product.iSanPhamId = (int)row["iSanPhamId"];
                    product.sTenSanPham = row["sTenSanPham"].ToString();
                    product.fDonGia = (float)Convert.ToDouble(row["fDonGia"]);
                    product.sAnh = row["sAnh"].ToString();
                    product.iSoLuong = (int)row["iSoLuong"];
                    productsLists.Add(product);
                }

                List<CartDetail> cartList = new List<CartDetail>();

                foreach (CartDetail product in productsLists)
                    {
                        if (product.iDonHangId.ToString() == idSanPham)
                        {
                            cartList.Add(product);
                        }
                    }
                
                ListViewCart.DataSource = cartList;
                ListViewCart.DataBind();
            }
        }
    }
}