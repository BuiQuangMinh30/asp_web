using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Website
{
    public partial class CartDefault : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
            Utility utility = new Utility();

            //========= Display page content==============
            List<ProductsList> productsLists = new List<ProductsList>();
            DataTable dataTable = utility.getAll_SanPham();

            foreach (DataRow row in dataTable.Rows)
            {
                ProductsList product = new ProductsList();
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
                List<ProductsList> cartList = new List<ProductsList>();
                //List<ProductsList> productsLists = (List<ProductsList>)Application["productsList"];

               
                string[] productsID = Request.Cookies["cart"].Value.Split(',');
                foreach (string productID in productsID)
                {
                    foreach (ProductsList product in productsLists)
                    {
                        if (product.idSanPham.ToString() == productID)
                        {
                            cartList.Add(product);
                        }
                    }
                }
                ListViewCart.DataSource = cartList;
                ListViewCart.DataBind();

                //Display total products
                if (Request.Cookies["cart"] != null)
                {
                    string[] cartProductsID = Request.Cookies["cart"].Value.Split(',');
                    // -1 empty string after last ,
                    total_products.InnerText = (cartProductsID.Length - 1).ToString();
                }
                else
                {
                    total_products.InnerText = "0";
                }

                //Display products price
                float productsPrice = 0;
                //DropDownList ddlQuantity = (DropDownList)ListViewCart.FindControl("ddlQuantity") as DropDownList;
                //string selectedQuantity = ddlQuantity.SelectedValue;

                foreach (ProductsList product1 in cartList) productsPrice += product1.fDonGia;
                products_price.InnerHtml = $"{productsPrice} <span class='cart__product-price-unit'>đ</span>";

                //Display delivery price
                const int DELIVERY = 50000;
                delivery_price.InnerHtml = $"{DELIVERY} <span class='cart__product-price-unit'>đ</span>";

                //Display order total price
                float orderTotal = productsPrice + DELIVERY;
                order_total_price.InnerHtml = $"{orderTotal} <span class='cart__product-price-unit'>đ</span>";
            }
        }
    }
}