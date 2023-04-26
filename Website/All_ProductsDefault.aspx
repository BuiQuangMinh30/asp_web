<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="All_ProductsDefault.aspx.cs" Inherits="Website.All_ProductsDefault" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="./styles/all_products.css">
</asp:Content>
<asp:Content ID="ContentSearch" ContentPlaceHolderID="ContentPlaceHolderSearch" runat="server">
    <div class="header__search">
        <img src="./Images/Icons/Search.png" alt="">
        <input type="text" name="search" placeholder="Search" id="search_text" onkeyup="filterName(this, event)">
        <button type="button" runat="server" id="search_button">Tìm</button>
    </div>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="all-products-page-content">
        <div class="total_Product">
            <h3></h3>
        </div>
        <div class="filter">
            <h3 class="filter__heading">Bộ lọc</h3>
            <%--<ul class="filter__list">
                    <li class="filter__item"><a href="#" runat="server" id="Filter_01">&le; 1 triệu</a></li>
                    <li class="filter__item"><a href="#" runat="server" id="Filter_02">1 - 3 triệu</a></li>
                    <li class="filter__item"><a href="#" runat="server" id="Filter_03">&ge; 3 triệu</a></li>
                </ul>--%>

            <div class="header__search">
                <%--<img src="./Images/Icons/Search.png" alt="">--%>
                <input type="number" name="search_1" placeholder="Giá trị đầu" id="Number1" onkeyup="filterMoney(this, event)">
                <%-- <button type="button" runat="server" id="search_button" onserverclick="SearchButton_Click">Tìm</button>--%>
            </div>

            <div class="header__search">
                <%--<img src="./Images/Icons/Search.png" alt="">--%>
                <input type="number" name="search_2" placeholder="Giá trị cuối" id="Number3" onkeyup="filterMoney(this, event)">
                <%-- <button type="button" runat="server" id="search_button" onserverclick="SearchButton_Click">Tìm</button>--%>
            </div>

            <%--<button type="button" runat="server" id="Button1" onclick="filterMoney(this, event)">Tìm</button>
                <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="Button" />--%>
        </div>
        <div class="sapxep">
                <p>Sắp xếp theo:</p>
                <select onchange="sortData(this)">
                    <option value="">----Chọn----</option>
                    <option value="sTenSanPham">Tên sản phẩm</option>
                    <option value="fDonGia">Giá sản phẩm</option>
                </select>
        </div>
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
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<div class="products__content">
                                <h4 class="products__name"><%# Eval("sTenSanPham") %></h4>
                                <%--<div class="products__colors">
                                        <div class="products__color--white"></div>
                                        <div class="products__color--black"></div>
                                        <div class="products__color--red"></div>
                                    </div>--%>
                                <p class="products__price">Giá: <%# Convert.ToDecimal(Eval("fDonGia")).ToString("N0").Replace(",", ".") %>&nbsp;₫</p>
                                <a class="products__button" href="Product_InformationDefault.aspx?id=<%# Eval("iSanPhamId") %>">Chi tiết</a>

                            </div>
                        </div>
                    </ItemTemplate>
                </asp:ListView>
            </div>
        </div>
    </div>

    <script>
        function sortData(select) {
            console.log(select, select.value);
        }
        function filterMoney(obj, e) {
            e.preventDefault();
            var txtSearch1 = document.getElementById("Number1").value;
            var txtSearch2 = document.getElementById("Number3").value;
            var xmlhttp = new XMLHttpRequest();
            xmlhttp.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {
                    var products = JSON.parse(this.responseText)
                    console.log('this', this.responseText, products)
                    var htmls = products.map(function (product, index) {
                        return `
                                <div class="products__wrapper">
                                <a href="Product_InformationDefault.aspx?id=${product.iSanPhamId}">
                                    <img class="products__image" src="${product.sAnh}" alt="">
                                </a>
                                <div class="products__content">
                                    <h4 class="products__name">${product.sTenSanPham}</h4>
                                    <p class="products__price">Giá: ${product.fDonGia}<span class="products__price-unit">VNĐ</span></p>
                                    <a class="products__button" href="Product_InformationDefault.aspx?id=<%# Eval("iSanPhamId") %>">Chi tiết</a>

                                </div>
                            </div>
                        `;
                    });
                    document.querySelector(".all-products__container").innerHTML = htmls;
                    document.querySelector(".total_Product").innerHTML = `<h3>Kết quả tìm kiếm(${products.length})</h3>`;
                }
            };
            var url = window.location.href + "?searchGia_1=" + txtSearch1 + "&searchGia_2=" + txtSearch2;
            xmlhttp.open("GET", "All_ProductsDefault.aspx?searchGia_1=" + txtSearch1 + "&searchGia_2=" + txtSearch2 + "", true);
            xmlhttp.send();
        }

        function filterName(obj, e) {
            console.log(e);
            e.preventDefault();
            var txtSearch = document.querySelector("#search_text").value;
            var txtSearch = document.querySelector("#search_text").value;
            document.title = "Tìm kiếm " + txtSearch;
            var xmlhttp = new XMLHttpRequest();
            xmlhttp.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {
                    var products = JSON.parse(this.responseText)
                    var htmls = products.map(function (product, index) {
                        return `
                                <div class="products__wrapper">
                                <a href="Product_InformationDefault.aspx?id=${product.iSanPhamId}">
                                    <img class="products__image" src="${product.sAnh}" alt="">
                                </a>
                                <div class="products__content">
                                    <h4 class="products__name">${product.sTenSanPham}</h4>
                                    <p class="products__price">Giá: ${product.fDonGia}<span class="products__price-unit">VNĐ</span></p>
                                    <a class="products__button" href="Product_InformationDefault.aspx?id=<%# Eval("iSanPhamId") %>">Chi tiết</a>

                                </div>
                            </div>
                        `;
                    });
                    document.querySelector(".all-products__container").innerHTML = htmls;
                }
            };
            var url = window.location.href + "?searchText=" + txtSearch;
            xmlhttp.open("GET", "All_ProductsDefault.aspx?searchText=" + txtSearch + "", true);
            xmlhttp.send();
        }
    </script>
</asp:Content>
