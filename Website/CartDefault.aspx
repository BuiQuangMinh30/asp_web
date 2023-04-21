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
                                <select onchange="updatePrice(this)" data-name=" <%# Eval("sTenSanPham") %>" name="quantity_<%# Eval("idSanPham")%>_<%# Container.DataItemIndex %>" data-price="<%# Eval("fDonGia") %>">
                                    <option value="0">Chọn số lượng</option>
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
                                <p class="cart__product-price" runat="server">
                                    0 <%--<span class="cart__product-price-unit">đ</span>--%>
                                </p>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:ListView>
            </div>
        </div>
        <div class="cart--right">
            <div id="isLogin" style="display: none" runat="server">-1</div>
            <h2 class="cart__title--right">Đơn hàng</h2>
            <div class="cart__products-total-price">
                <p>Tổng tiền <span runat="server" id="total_products">0</span> sản phẩm</p>
                <p id="products_price">0 <span class="cart__product-price-unit">đ</span></p>
            </div>
            <div class="cart__delivery-price">
                <p>Tổng phí giao hàng</p>
                <p id="delivery_price">50000 <span class="cart__product-price-unit">đ</span></p>
            </div>
            <hr />
            <div class="cart__order-total">
                <p>Tổng cộng: </p>
                <p id="order_total_price" class="order_total_price">0 <span class="cart__product-price-unit">đ</span></p>
            </div>
            <hr />
            <div class="cart__buttons--right">
                <button class="purchase-button" id="checkoutBtn" type="button">Thanh toán</button>
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

        //IIFE khởi tạo giá trị tiền khi chưa chọn sản phẩm
        const InitPrice = (() => {
            var deliveryElement = document.querySelector("#delivery_price");
            var products_PriceElement = document.querySelector("#products_price");
            var order_Total_PriceElement = document.querySelector("#order_total_price");
            var cart_Product_Elements = document.querySelectorAll(".cart__product-price");

            //set giá trị mặc định là 0 khi chưa chọn
            var cart_Product = 0;
            var delivery_price = 50000;
            var product_price = 0;
            var total_price = delivery_price + product_price;

            //Định dạng lại thành chuỗi tiền tệ bằng phương thức toLocaleString() của Number
            cart_Product_Elements.forEach((element, index) => {
                element.innerText = cart_Product.toLocaleString('vi-VN', { style: 'currency', currency: 'VND' });
            });
            deliveryElement.innerText = delivery_price.toLocaleString('vi-VN', { style: 'currency', currency: 'VND' });
            products_PriceElement.innerText = product_price.toLocaleString('vi-VN', { style: 'currency', currency: 'VND' });
            order_Total_PriceElement.innerText = total_price.toLocaleString('vi-VN', { style: 'currency', currency: 'VND' });
        })();

        function updatePrice(select) {

            //Lấy phần tử cha của phần tử select chứa phần tử price
            var productWrapper = select.closest(".cart__product-wrapper");

            // Lấy phần tử price bên trong phần tử cha
            var priceElement = productWrapper.querySelector(".cart__product-price");

            //Lấy số lượng chọn
            var selectedQuantity = select.value;

            // Lấy đơn giá mỗi mặt hàng từ thuộc tính data-price
            var pricePerItem = parseFloat(select.dataset.price);

            // Tính giá mới
            var newPrice = pricePerItem * selectedQuantity;

            //Cập nhập giá mới
            priceElement.innerText = newPrice.toLocaleString('vi-VN', { style: 'currency', currency: 'VND' });

            // Đặt giá trị đã chọn của phần tử được chọn
            select.value = selectedQuantity;

            updateOrderTotal();
        }

        function updateOrderTotal() {
            //Lấy tất cả các element select
            var selectElements = document.querySelectorAll("select[name^='quantity_']");

            //Khởi tạo tổng tiền = 0
            var total = 0;

            //Khởi tạo số sản phẩm
            var totalProcduct = 0;

            // Lặp lại tất cả các select và cộng giá
            for (var i = 0; i < selectElements.length; i++) {
                var select = selectElements[i];

                // Lấy phần tử cha của phần tử select chứa phần tử price
                var productWrapper = select.closest(".cart__product-wrapper");

                // Lấy phần tử price bên trong phần tử cha
                var priceElement = productWrapper.querySelector(".cart__product-price");

                // Lấy số lượng đã chọn
                var selectedQuantity = select.value;

                // Lấy đơn giá mỗi mặt hàng từ thuộc tính data-price
                var pricePerItem = parseFloat(select.dataset.price);

                // Tính giá của mặt hàng hiện tại và thêm nó vào tổng
                var itemPrice = pricePerItem * selectedQuantity;
                total += itemPrice;

                //số sản phẩm trong giỏ hàng
                totalProcduct++;
            }

            //Upadate số tổng sản phẩm trong giỏ hàng
            var totalProduct = document.getElementsByClassName("order_total_price");
            totalProduct.innerText = totalProcduct;

            //Upadate số tổng tiền chưa phí ship
            var totalProductPriceElement = document.getElementById("products_price");
            totalProductPriceElement.innerText = total.toLocaleString('vi-VN', { style: 'currency', currency: 'VND' });

            // Update the order total price element with the new total
            var orderTotalElement = document.getElementById("order_total_price");
            var orderTotal = total + 50000;
            orderTotalElement.innerText = orderTotal.toLocaleString('vi-VN', { style: 'currency', currency: 'VND' });
        }
    </script>


    <script>
        //Lấy ra các thẻ select
        var selectElements = document.querySelectorAll("select[name^='quantity_']");
        var isLogin = document.getElementById("<%= isLogin.ClientID %>").textContent;

        //Sự kiện click thì gửi số lượng các mặt hàng sang cho trang thanh toán
        document.querySelector('button').onclick = function (e) {
            // Duyệt qua từng select để kiểm tra xem người dùng đã chọn giá trị hay chưa
            for (var i = 0; i < selectElements.length; i++) {
                var select = selectElements[i];
                if (select.value === "" || select.value === "0") {
                    alert("Bạn chưa chọn giá trị cho " + select.dataset.name);
                    return;
                }
            }
            if (isLogin == "0") {
                alert("Hãy đăng nhập trước khi tiến hành thanh toán.")
                window.location.href = 'signIn.aspx';
            }
            else {
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
            }
        };
    </script>
</asp:Content>
