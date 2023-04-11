<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="IndexDefault.aspx.cs" Inherits="Website.IndexDefault" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
                        <div class="products__nike">
                            <div class="products__heading">
                                <h2 class="products__brand-name">Chó</h2>
                                <a href="All_ProductsDefault.aspx?type=dog">Xem thêm</a>
                            </div>

                            <div class="products__left-arrow"></div>

                            <div class="products__slide">
                                <div class="products__slide-wrapper">
                                    <asp:ListView ID="ListViewNikeSlideProducts" runat="server">
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
                                                    <p class="products__price">Giá: <%# Eval("price") %> <span class="products__price-unit">đ</span></p>
                                                    <a class="products__button" href="Product_InformationDefault.aspx?id=<%# Eval("id") %>">Chi tiết</a>
                                                </div>
                                            </div>

                                        </ItemTemplate>
                                    </asp:ListView>
                                </div>        
                            </div>
                            

                            <div class="products__right-arrow"></div>
                        </div>

                        <div class="products__adidas">
                            <div class="products__heading">
                                <h2 class="products__brand-name">Mèo</h2>
                                <a href="All_ProductsDefault.aspx?type=cat">Xem thêm</a>
                            </div>

                            <div class="products__left-arrow"></div>

                            <div class="products__slide">
                                <div class="products__slide-wrapper">

                                    <asp:ListView ID="ListViewAdidasSlideProducts" runat="server">
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
                                                    <p class="products__price">Giá: <%# Eval("price") %> <span class="products__price-unit">đ</span></p>
                                                    <a class="products__button" href="Product_InformationDefault.aspx?id=<%# Eval("id") %>">Chi tiết</a>
                                                </div>
                                            </div>

                                        </ItemTemplate>
                                    </asp:ListView>
                                    
                                </div>
                            </div>

                            <div class="products__right-arrow"></div>
                        </div>

                        <div class="products__puma">
                            <div class="products__heading">
                                <h2 class="products__brand-name">Khác</h2>
                                <a href="All_ProductsDefault.aspx?type=diff">Xem thêm</a>
                            </div>

                            <div class="products__left-arrow"></div>

                            <div class="products__slide">
                                <div class="products__slide-wrapper">
                                    <asp:ListView ID="ListViewPumaSlideProducts" runat="server">
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
                                                    <p class="products__price">Giá: <%# Eval("price") %> <span class="products__price-unit">đ</span></p>
                                                    <a class="products__button" href="Product_InformationDefault.aspx?id=<%# Eval("id") %>">Chi tiết</a>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:ListView>
                                </div>
                            </div>
                            <div class="products__right-arrow"></div>
                        </div>
                    </div>
                </div>
</asp:Content>
