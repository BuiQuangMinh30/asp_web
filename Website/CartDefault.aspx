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
                                        <%--<p class="cart__product-quantity">Số lượng: 1</p>--%>
                                        <select name="quantity_<%# Eval("idSanPham")%>_<%# Container.DataItemIndex %>">
                                            <option value="1">1</option>
                                            <option value="2">2</option>
                                            <option value="3">3</option>
                                            <option value="4">4</option>
                                        </select>
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
                        <%--<asp:Button class="purchase-button" ID="Button1" runat="server" Text="Thanh toán" OnClick="Button1_Click"/>--%>
                        <%--<button  type="button">Thanh toán</button>--%>
                        <button class="purchase-button"  id="checkoutBtn" type="button">Thanh toán</button>
                    </div>
                </div>
            </div>

  <%--  <script>
        document.querySelector('button').onclick = function (e) {
            // Lấy tất cả các dropdownlist trong trang
            var dropdowns = document.getElementsByTagName('select');

            // Tạo một mảng lưu trữ các cặp key-value (productId:quantity)
            var params = [];

            // Duyệt qua từng dropdownlist
            for (var i = 0; i < dropdowns.length; i++) {
                var dropdown = dropdowns[i];

                // Lấy giá trị số lượng được chọn từ dropdownlist
                var quantity = dropdown.value;

                // Tách lấy idSanPham và DataItemIndex từ tên của select
                var nameParts = dropdown.name.split('_');
                var idSanPham = nameParts[1];
                var dataItemIndex = nameParts[2];

                // Thêm cặp key-value (productId:quantity) vào mảng params
                params.push('quantity[' + idSanPham + '][' + dataItemIndex + ']=' + encodeURIComponent(quantity));
            }

            // Tạo URL chứa các tham số truyền đi
            var url = 'Payment.aspx?' + params.join('&');

            // Chuyển hướng sang trang thanh toán
            window.location.href = url;
        };
    </script>--%>

    <script>
        document.querySelector('button').onclick = function (e) {
          
            // Lấy tất cả các dropdownlist trong trang
            var dropdowns = document.getElementsByTagName('select');

            // Tạo một đối tượng FormData để lưu trữ dữ liệu sẽ được gửi đi
            var formData = new FormData();

            // Duyệt qua từng dropdownlist
            for (var i = 0; i < dropdowns.length; i++) {
                var dropdown = dropdowns[i];

                // Lấy giá trị số lượng được chọn từ dropdownlist
                var quantity = dropdown.value;

                // Tách lấy idSanPham và dataItemIndex từ tên của select
                var nameParts = dropdown.name.split('_');
                var idSanPham = nameParts[1];
                var dataItemIndex = nameParts[2];

                // Thêm cặp key-value (productId:quantity) vào đối tượng FormData
                formData.append('quantity[' + idSanPham + '][' + dataItemIndex + ']', quantity);
            }

            // Gửi dữ liệu sang trang thanh toán
            var xhr = new XMLHttpRequest();
            xhr.open('POST', 'FormCart.aspx');
            xhr.onload = function () {
                if (xhr.status === 200) {
                    window.location.href = 'FormCart.aspx';
                }
                else {
                    alert("Đã có lỗi xảy ra khi gửi dữ liệu");
                }
            };
            xhr.send(formData);
        };
    </script>
</asp:Content>
