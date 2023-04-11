using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Website
{
    public partial class All_ProductsDefault : System.Web.UI.Page
    {
        protected void getProductsListByTypeAndFilter(string type, int begin, int end, List<ProductsList> productsListsByTypeAndFilter, List<ProductsList> productsLists)
        {
            foreach (ProductsList product in productsLists)
            {
                if (type == product.type && Int32.Parse(product.price) >= begin && Int32.Parse(product.price) <= end)
                {
                    productsListsByTypeAndFilter.Add(product);
                }
            }
            ListViewAllProducts.DataSource = productsListsByTypeAndFilter;
            ListViewAllProducts.DataBind();
        }

        protected void getProductsListBySearchAndFilter(string search, int begin, int end, List<ProductsList> productsListsBySearchAndFilter, List<ProductsList> productsLists)
        {
            foreach (ProductsList product in productsLists)
            {
                if (product.name.ToLower().IndexOf(search) != -1 && Int32.Parse(product.price) >= begin && Int32.Parse(product.price) <= end)
                {
                    productsListsBySearchAndFilter.Add(product);
                }
            }
            ListViewAllProducts.DataSource = productsListsBySearchAndFilter;
            ListViewAllProducts.DataBind();
        }

        protected string totalProducts(List<ProductsList> productsListsByTypeAndFilter)
        {
            int total = 0;
            foreach (ProductsList product in productsListsByTypeAndFilter)
                total++;
            return total.ToString();
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            string type = Request.QueryString.Get("type");
            string search = Request.QueryString.Get("search");
            string filter = Request.QueryString.Get("filter");

            if (type != null || search != null)
            {
                List<ProductsList> productsLists = (List<ProductsList>)Application["productsList"];


                if (type != null)
                {
                    //======Display page content
                    //Display products
                    type = type.ToLower();

                    if (type == "dog" || type == "cat" || type == "diff")
                    {
                        //Change page title
                        Page.Title = type.ToUpper();
                        //Create Products List
                        List<ProductsList> productsListByTypeAndFilter = new List<ProductsList>();
                        //Filter
                        if (filter != null)
                        {
                            if (filter == "01")
                            {
                                getProductsListByTypeAndFilter(type, 0, 1000000, productsListByTypeAndFilter, productsLists);
                                all_products_brand_name.InnerText = $"{type} Dưới 1 triệu ({totalProducts(productsListByTypeAndFilter)})";
                            }

                            if (filter == "02")
                            {
                                getProductsListByTypeAndFilter(type, 1000000, 3000000, productsListByTypeAndFilter, productsLists);
                                all_products_brand_name.InnerText = $"{type} Từ 1 - 3 triệu ({totalProducts(productsListByTypeAndFilter)})";
                            }

                            if (filter == "03")
                            {
                                getProductsListByTypeAndFilter(type, 3000000, 999999999, productsListByTypeAndFilter, productsLists);
                                all_products_brand_name.InnerText = $"{type} Trên 3 triệu ({totalProducts(productsListByTypeAndFilter)})";
                            }
                        }
                        else
                        {
                            getProductsListByTypeAndFilter(type, 0, 999999999, productsListByTypeAndFilter, productsLists);
                            all_products_brand_name.InnerText = $"{type} ({totalProducts(productsListByTypeAndFilter)})";
                        }
                    }
                }
                else if (search != null)
                {
                    //======Display Page Content
                    //Display Products
                    search = search.ToLower();

                    //Change page title
                    Page.Title = "Tìm kiếm";

                    //Create Products List
                    List<ProductsList> productsListBySearchAndFilter = new List<ProductsList>();

                    if (filter != null)
                    {
                        if (filter == "01")
                        {
                            getProductsListBySearchAndFilter(search, 0, 1000000, productsListBySearchAndFilter, productsLists);
                            all_products_brand_name.InnerText = $"Kết quả tìm kiếm cho '{search}' Dưới 1 triệu ({totalProducts(productsListBySearchAndFilter)})";
                        }

                        if (filter == "02")
                        {
                            getProductsListBySearchAndFilter(search, 1000000, 3000000, productsListBySearchAndFilter, productsLists);
                            all_products_brand_name.InnerText = $"Kết quả tìm kiếm cho '{search}' Từ 1 - 3 triệu ({totalProducts(productsListBySearchAndFilter)})";
                        }

                        if (filter == "03")
                        {
                            getProductsListBySearchAndFilter(search, 3000000, 999999999, productsListBySearchAndFilter, productsLists);
                            all_products_brand_name.InnerText = $"Kết quả tìm kiếm cho '{search}' Trên 3 triệu ({totalProducts(productsListBySearchAndFilter)})";
                        }
                    }
                    else
                    {
                        getProductsListBySearchAndFilter(search, 0, 999999999, productsListBySearchAndFilter, productsLists);
                        all_products_brand_name.InnerText = $"Kết quả tìm kiếm cho '{search}' ({totalProducts(productsListBySearchAndFilter)})";
                    }
                }


                //Add filter href
                string currentUrl = Request.Url.ToString();
                int andSignPosition = currentUrl.IndexOf('&');
                if (andSignPosition != -1)
                {
                    //Avoid multiple filter if already having a filter, ex: example.aspx?type=nike&filter=01&filter=02,...
                    string currentUrlWithOutFilter = currentUrl.Substring(0, andSignPosition);
                    //Filter_01.HRef = $"{currentUrlWithOutFilter}&filter=01";
                    //Filter_02.HRef = $"{currentUrlWithOutFilter}&filter=02";
                    //Filter_03.HRef = $"{currentUrlWithOutFilter}&filter=03";
                }
                else
                {
                    //Filter_01.HRef = $"{currentUrl}&filter=01";
                    //Filter_02.HRef = $"{currentUrl}&filter=02";
                    //Filter_03.HRef = $"{currentUrl}&filter=03";
                }
            }
            else
                Response.Redirect("index.aspx");
        }
    }
}