<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="All_ProductsDefault.aspx.cs" Inherits="Website.All_ProductsDefault" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="./styles/all_products.css">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="all-products-page-content">
            <div class="filter">
                <h3 class="filter__heading">Bộ lọc</h3>
                <ul class="filter__list">
                    <li class="filter__item"><a href="#" runat="server" id="Filter_01">&le; 1 triệu</a></li>
                    <li class="filter__item"><a href="#" runat="server" id="Filter_02">1 - 3 triệu</a></li>
                    <li class="filter__item"><a href="#" runat="server" id="Filter_03">&ge; 3 triệu</a></li>
                </ul>
                <asp:TextBox ID="txtSearch" runat="server" onkeyup="filterListView();"/>
              
                <br />
               <%--<input id="Text1" type="text" style="height: 42px" onkeyup="showProduct(this.value)"/>
                <asp:Button ID="Button1" runat="server" Text="Button" />--%>
            </div>
        <span id="txtHint"></span>
            <div class="all-products">
                <div class="all-products_heading">
                    <h2 class="all-products_brand-name" runat="server" id="all_products_brand_name"></h2>
                </div>
                <div class="all-products__container">
                    <asp:ListView ID="ListViewAllProducts" runat="server">
                        <ItemTemplate>
                            <div class="products__wrapper">
                                <a href="Product_InformationDefault.aspx?id=<%# Eval("iSanPhamId") %>">
                                    <img class="products__image" src="<%# Eval("sAnh") %>" alt="">
                                </a>
                                &nbsp;&nbsp;<div class="products__content">
                                    <h4 class="products__name"><%# Eval("sTenSanPham") %></h4>
                                    <%--<div class="products__colors">
                                        <div class="products__color--white"></div>
                                        <div class="products__color--black"></div>
                                        <div class="products__color--red"></div>
                                    </div>--%>
                                    <p class="products__price">Giá: <%# Convert.ToDecimal(Eval("fDonGia")).ToString("N0").Replace(",", ".") %><span class="products__price-unit">VNĐ</span></p>
                                    <a class="products__button" href="Product_InformationDefault.aspx?id=<%# Eval("iSanPhamId") %>">Chi tiết</a>
                                </div>
                            </div>   
                        </ItemTemplate>
                    </asp:ListView>
                </div>
            </div>
        </div>

    <script>
        function filterListView() {
            var searchText = document.getElementById('<%= txtSearch.ClientID %>').value;

            var xmlhttp = new XMLHttpRequest();
            xmlhttp.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {
                    var lvItems = document.getElementById('<%= ListViewAllProducts.ClientID %>');
                    if (lvItems != null) {
                        lvItems.innerHTML = this.responseText;
                    }
                }
            };
            xmlhttp.open("GET", "All_ProductsDefault.aspx?searchText=" + searchText, true);
            xmlhttp.send();
        }
    </script>
</asp:Content>
