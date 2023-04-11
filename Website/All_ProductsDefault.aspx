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
            </div>
            <div class="all-products">
                <div class="all-products_heading">
                    <h2 class="all-products_brand-name" runat="server" id="all_products_brand_name"></h2>
                </div>
                <div class="all-products__container">
                    <asp:ListView ID="ListViewAllProducts" runat="server">
                        <ItemTemplate>
                            <div class="products__wrapper">
                                <a href="Product_InformationDefault.aspx?id=<%# Eval("id") %>">
                                    <img class="products__image" src="<%# Eval("img") %>" alt="">
                                </a>
                                <div class="products__content">
                                    <h3 class="products__name"><%# Eval("name") %></h3>
                                    <%--<div class="products__colors">
                                        <div class="products__color--white"></div>
                                        <div class="products__color--black"></div>
                                        <div class="products__color--red"></div>
                                    </div>--%>
                                    <p class="products__price">Giá: <%# Eval("price") %><span class="products__price-unit">đ</span></p>
                                    <a class="products__button" href="Product_InformationDefault.aspx?id=<%# Eval("id") %>">Chi tiết</a>
                                </div>
                            </div>   
                        </ItemTemplate>
                    </asp:ListView>
                </div>
            </div>
        </div>
</asp:Content>
