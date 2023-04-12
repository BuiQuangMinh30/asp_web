<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="IndexDefault.aspx.cs" Inherits="Website.IndexDefault" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <link rel="stylesheet" href="./styles/all_products.css">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="index-page-content">
                    <div class="slider">
                        <div class="slider__wrapper">
                            <div class="slider__images-container">
                                <img src="./Images/Nike/anhbanner.jpg" alt="" style="width:1350px;">
                                <%--<img src="./Images/Adidas/anhbannermeo.jpg" alt="">--%>
                                <%--<img src="./Images/Puma/anhbannerchim.jpg" alt="">--%>
                            </div>
                        </div>
                        <div class="slider__content">
                            <div class="slider__heading">
                               <%-- <h1>PET STORE</h1>
                                <p>Shop chăm sóc thú cưng</p>--%>
                            </div>
                        </div>
                       <%--<div class="slider__circles">
                            <div class="slider__circle active"></div>
                            <div class="slider__circle"></div>
                            <div class="slider__circle"></div>
                        </div>--%>
                    </div>
        
                    <div class="products">
                        <div class="all-products">
                <div class="all-products_heading">
                    <h2 class="all-products_brand-name" runat="server" id="H1"></h2>
                </div>
                <div class="all-products__container">
                   <asp:ListView ID="ListView2" runat="server">
                                        <ItemTemplate>

                                            <div class="products__wrapper">
                                                <a href="Product_InformationDefault.aspx?id=<%# Eval("iSanPhamId") %>">
                                                    <img class="products__image" src="<%# Eval("sAnh") %>" alt="">
                                                </a>
                                                <div class="products__content">
                                                    <h3 class="products__name"><%# Eval("sTenSanPham") %></h3>
                                                    <%--<div class="products__colors">
                                                        <div class="products__color--white"></div>
                                                        <div class="products__color--black"></div>
                                                        <div class="products__color--red"></div>
                                                    </div>--%>
                                                    <p class="products__price">Giá: <%# Eval("fDonGia") %> <span class="products__price-unit">đ</span></p>
                                                    <a class="products__button" href="Product_InformationDefault.aspx?id=<%# Eval("iSanPhamId") %>">Chi tiết</a>
                                                </div>
                                            </div>

                                        </ItemTemplate>
                                    </asp:ListView>
                </div>
            </div>

                      
                    </div>
                </div>
</asp:Content>
