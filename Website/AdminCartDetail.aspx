<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminCartDetail.aspx.cs" Inherits="Website.AdminCartDetail" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      <div class="cart__products-container">
                <asp:ListView ID="ListViewCart" runat="server">
                    <ItemTemplate>
                        <div class="cart__product-wrapper">
                           
                            <div class="cart__product-information">
                                <p class="cart__product-name">
                                    <%# Eval("iSanPhamId") %>
                                </p>
                               <p class="cart__product-price" id="dongia">
                                    <%# Eval("fDonGia") %>
                                </p>

                                 <p class="cart__product-price">
                                    <%# Eval("iSoLuong") %>
                                </p>
                               
                                <div class="cart__buttons--left">
                                    <%--<a class="delete-button cart__button" href="DeleteCartDefault.aspx?id=<%# Eval("idSanPham") %>">Xoá khỏi giỏ hàng</a>
                                    <a class="information-button cart__button" href="Product_InformationDefault.aspx?id=<%# Eval("idSanPham") %>">Chi tiết</a>--%>
                                </div>
                            </div>
                           <%-- <div class="cart__product-price-wrapper">
                                <p class="cart__product-price" runat="server" >
                                    0 
                                </p>
                            </div>--%>
                        </div>
                    </ItemTemplate>
                </asp:ListView>
            </div>
</asp:Content>
