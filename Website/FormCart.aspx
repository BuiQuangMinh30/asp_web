<%@ Page  Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="FormCart.aspx.cs" Inherits="Website.FormCart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="./styles/formcart.css">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderSearch" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="content">
        <div id="checkout-order-form">
            <h2>Thông tin thanh toán</h2>
            <fieldset id="fieldset-billing">
                <legend>Hóa đơn</legend>
                <div>
                    <label for="name">Họ tên</label>
                    <input type="text" name="name" id="name" />
                </div>
                <div>
                    <label for="email">Email</label>
                    <input type="text" name="email" id="email" />
                </div>
                <div>
                    <label for="number">Số điện thoại</label>
                    <input type="text" name="phone" id="number" />
                </div>
                <div>
                    <label for="address">Địa chỉ giao hàng</label>
                    <input type="text" name="address" id="address" />
                </div>

                <div>
                    <label for="type">Hình thức thanh toán</label>
                    <select name="country" id="country">
                        <option value="">Thanh toán khi nhận hàng</option>
                        <option value="IN">Thanh toán chuyển khoản</option>
                    </select>
                </div>
            </fieldset>
            <asp:Button CssClass="btn_submit" ID="btnAdd_Product" runat="server" Text="Thanh toán" OnClick="btnAdd_Product_Click" />
        </div>
    </div>
</asp:Content>
