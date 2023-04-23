<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminCartDetail.aspx.cs" Inherits="Website.AdminCartDetail" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="./styles/cart.css">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      

    <div class="cart--left">
            <h2 class="cart__title--left">Chi tiết đơn hàng</h2>
            <div class="cart__products-container">
                <asp:ListView ID="ListViewCart" runat="server">
                    <ItemTemplate>
                        <div class="cart__product-wrapper">
                            <div class="cart__product-image-wrapper">
                                <img class="cart__product-image" src="<%# Eval("sAnh") %>" alt="">
                            </div>
                            <div class="cart__product-information">
                                <p class="cart__product-name">
                                    Tên sản phẩm: 
                                    <%# Eval("sTenSanPham") %>
                                </p>
                               <%-- <p class="cart__product-price" id="dongia">
                                    <%# Eval("fDonGia") %>
                                </p>--%>
                                 <p class="cart__product-quantity">
                                  Số lượng:  <%# Eval("iSoLuong") %>
                                </p>
                               
                            </div>
                            <div class="cart__product-price-wrapper">
                                <p class="cart__product-price" runat="server" >
                                 Tổng tiền:   <%# Convert.ToDecimal(Eval("fDonGia")).ToString("N0").Replace(",", ".") %>  <span class="products__price-unit">VNĐ</span></p>
                                </p>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:ListView>
            </div>
        </div>
</asp:Content>
