<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="CartDefault.aspx.cs" Inherits="Website.CartDefault" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="./styles/cart.css">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="cart-page-content">
                <div class="cart--left">
                    <h2 class="cart__title--left">Giỏ hàng</h2>
                    <div class="cart__products-container">
                        <asp:ListView ID="ListViewCart" runat="server">
                            <ItemTemplate>
                                <div class="cart__product-wrapper">
                                    <div class="cart__product-image-wrapper">
                                        <img class="cart__product-image" src="<%# Eval("sAnh") %>" alt="">
                                    </div>
                                    <div class="cart__product-information">
                                        <p class="cart__product-name">
                                            <%# Eval("sTenSanPham") %>
                                        </p>
                                       <%-- <p>Giày thể thao</p>--%>
                                        <%--<p>Màu: <span>
                                                <%# Eval("color") %>    
                                            </span></p>--%>
                                        <div class="cart__product-quantity-wrapper">
                                            <label class="cart__product-quantity-label">Số lượng:</label>
                                            <select id="quantity" name="quantity" title="Chọn số lượng" class="cart__product-quantity" runat="server">
                                                <option value="1" selected="selected">1</option>
                                                <option value="2">2</option>
                                                <option value="3">3</option>
                                                <option value="4">4</option>
                                                <option value="5">5</option>
                                                <option value="6">6</option>
                                                <option value="7">7</option>
                                                <option value="8">8</option>
                                                <option value="9">9</option>
                                                <option value="10">10</option>
                                            </select>
                                        </div>
                                        <div class="cart__buttons--left">
                                            <a class="delete-button cart__button" href="DeleteCartDefault.aspx?id=<%# Eval("idSanPham") %>">Xoá khỏi giỏ hàng</a>
                                            <a class="information-button cart__button" href="Product_InformationDefault.aspx?id=<%# Eval("idSanPham") %>">Chi tiết</a>
                                        </div>
                                    </div>
                                    <div class="cart__product-price-wrapper">
                                        <p class="cart__product-price">
                                            <%# Eval("fDonGia") %> <span class="cart__product-price-unit">đ</span>
                                        </p>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:ListView>
                    </div>
                </div>
                <div class="cart--right">
                    <h2 class="cart__title--right">Đơn hàng</h2>
                    <div class="cart__products-total-price">
                        <p>Tổng tiền <span runat="server" id="total_products">0</span> sản phẩm</p>
                        <p runat="server" id="products_price">0 <span class="cart__product-price-unit">đ</span></p>
                    </div>
                    <div class="cart__delivery-price">
                        <p>Tổng phí giao hàng</p>
                        <p runat="server" id="delivery_price">0 <span class="cart__product-price-unit">đ</span></p>
                    </div>
                    <hr>
                    <div class="cart__order-total">
                        <p>Tổng cộng: </p>
                        <p runat="server" id="order_total_price">0 <span class="cart__product-price-unit">đ</span></p>
                    </div>
                    <hr>
                    <div class="cart__buttons--right">
                        <button class="purchase-button" type="button">Thanh toán</button>
                    </div>
                </div>
            </div>
</asp:Content>
