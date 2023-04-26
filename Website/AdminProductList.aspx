<%@ Page Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminProductList.aspx.cs" Inherits="Website.AdminProductList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="admin-content-right">
        <div class="admin-content-right-cartegory_list">
            <h1>Danh sách sản phẩm</h1>
            <table>
                <tr>
                    <th>ID</th>
                    <th>Tên danh mục</th>
                    <th>Tên sản phẩm</th>
                    <th>Đơn giá</th>
                    <th>Mô tả</th>
                    <th>Ảnh</th>
                    <th>Thời gian tạo</th>
                    <th>Tùy biến</th>
                </tr>
                <asp:ListView ID="listProduct" runat="server">
                    <ItemTemplate>
                        <tr data-id="<%# Eval("iSanPhamId") %>">
                            <td><%# Eval("iSanPhamId") %></td>
                            <td class="productCate" data-id="<%# Eval("iDanhMucId") %>"><%# Eval("sTenDanhMuc") %></td>
                            <td class="productName"><%# Eval("sTenSanPham") %></td>
                            <td class="productPrice"><%# Eval("fDonGia") %></td>
                            <td class="productDesc"><%# Eval("sMoTa") %></td>
                            <%--<td><%# Eval("sAnh") %></td>--%>
                            <td class="productImg" data-img="<%# Eval("sAnh") %>">
                                <image width="70px" height="70px" src="<%# Eval("sAnh") %>" alt="" />
                            </td>
                            <td><%# Eval("dThoiGianTao", "{0:dd/MM/yyyy}") %></td>
                            <%--  <td><a href="#">Sửa</a>|<a href="#">Xóa</a></td>--%>
                            <td>
                                <button class="admin-edit-button" style="margin: 4px 0px" id="sua_<%# Eval("iSanPhamId") %>"<%-- onclick="btnSua(this, <%# Eval("iSanPhamId") %>, event)"--%>>
                                    <a href="AdminEditProduct.aspx?id=<%# Eval("iSanPhamId") %>">Sửa</a>
                                </button>
                                <button class="admin-delete-button" style="margin-right: 0px" id="xoa_<%# Eval("iSanPhamId") %>" onclick="btnXoa(this, <%# Eval("iSanPhamId") %>, event)">Xóa</button>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:ListView>
            </table>
            <div class="pager">
                <asp:DataPager ID="DataPager1" runat="server" PagedControlID="listProduct" PageSize="5">
                    <Fields>
                        <asp:NumericPagerField ButtonType="Link" />
                        <asp:NextPreviousPagerField NextPageText="Tiếp" PreviousPageText="Trước" LastPageText="Cuối" ShowLastPageButton="True" ShowFirstPageButton="True" FirstPageText="Đầu" />
                    </Fields>
                </asp:DataPager>
            </div>
        </div>
        <!-- The Modal -->
        <div id="editProductModal" class="modal">

            <!-- Modal content -->
            <div class="modal-content form_wrapper">
                <span class="close">&times;</span>
                <h2 style="text-align: center">Sửa sản phẩm</h2>
                <div class="edit-form">
                    <input type="hidden" name="productId" />

                    <label for="categoryName">Tên danh mục<span style="color: red;">*</span></label>
                    <select name="categoryName">
                        <asp:ListView ID="ListView1" runat="server">
                            <ItemTemplate>
                                 <option value="<%# Eval("iDanhMucId") %>"><%# Eval("sTenDanhMuc") %></option>
                            </ItemTemplate>
                        </asp:ListView>
                    </select>
                    <label for="productName">Tên sản phẩm<span style="color: red;">*</span></label>
                    <input type="text" id="productName" name="productName">

                    <label for="productPrice">Đơn giá sản phẩm<span style="color: red;">*</span></label>
                    <input type="text" id="productPrice" name="productPrice">

                    <label for="productDesc">Mô tả sản phẩm<span style="color: red;">*</span></label>
                    <textarea type="text" id="productDesc" name="productDesc" value="" cols="30" rows="10"></textarea>

                    <label for="productImg">Ảnh mới<span style="color: red;">*</span></label>
                    <input type="file" id="productImg" name="productImg">

                    <button id="saveProductBtn" class="btn_submit" type="button">Lưu</button>
                    <button id="cancelProductBtn" class="btn_submit" type="button">Hủy</button>
                </div>
            </div>
        </div>
    </div>

   <%-- <script>
        //Sửa sản phẩm
        var btnEdits = document.querySelectorAll('button[id^="sua_"]');
        var close = document.querySelector('.close');

        //Hàm server side
        function updateCategory(product) {
            var xhttp = new XMLHttpRequest();
            xhttp.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {
                    // Nhận phản hồi từ server và xử lý dữ liệu trả về ở đây
                    var result = JSON.parse(this.responseText);
                    //console.log(result);
                    alert(result.d);
                    updateRowOnTable(product);
                }
            };
            var data = JSON.stringify(product);
            //console.log(data);
            xhttp.open("POST", "AdminProductList.aspx/suaSanPham", true);
            xhttp.setRequestHeader("Content-type", "application/json");
            xhttp.send(data);
        }

        //Hàm cập nhập dữ liệu khi nhận được phản hồi từ server
        function updateRowOnTable(product) {
            var row = document.querySelector("tr[data-id='" + product.id + "']");
            row.querySelector(".productName").innerHTML = product.name;
            row.querySelector(".productDesc").innerHTML = product.desc;
            row.querySelector(".productPrice").innerHTML = product.price;
            row.querySelector(".productImg").querySelector("img").src = "./Images/" + product.img;
            row.querySelector(".productCate").innerHTML = product.nameCate;
        }

        //Click Edit
        btnEdits.forEach(function (button, index) {
            button.onclick = function (event) {
                event.preventDefault();
                var idElement = this.id;
                var arr = idElement.split(",");
                var action = arr[0];
                var id_Product = arr[1];
                var data = {
                    id: id_Product,
                }
                var formEdit = document.querySelector('#editProductModal');
                formEdit.classList.add('show');

                //Lấy ra giá trị của các cột
                var row = button.closest('tr');

                var product = {
                    id: row.getAttribute("data-id"),
                    idCate: row.querySelector(".productCate").dataset.id,
                    nameCate: row.querySelector(".productCate").innerHTML,
                    name: row.querySelector(".productName").innerHTML,
                    desc: row.querySelector(".productDesc").innerHTML,
                    price: row.querySelector(".productPrice").innerHTML,
                    img: row.querySelector(".productImg").dataset.img,
                }

                //console.log(product);
                let form = document.querySelector(".edit-form");
                var productIdInput = form.querySelector('input[name="productId"]');
                var productCateInput = form.querySelector('select[name="categoryName"]');
                var productNameInput = form.querySelector('input[name="productName"]');
                var productPriceInput = form.querySelector('input[name="productPrice"]');
                var productDescInput = form.querySelector('textarea[name="productDesc"]');
                var productImgInput = form.querySelector('input[name="productImg"]');

                //Gán giá trị cho các ô trong form sửa
                productIdInput.value = product.id;
                productNameInput.value = product.name;
                productDescInput.value = product.desc;
                productPriceInput.value = product.price;
                //Set option cho select
                var option = productCateInput.querySelector(`option[value="${product.idCate}"]`);
                if (option) {
                    option.selected = true;
                }

                //Sự kiện click nút lưu
                var btnLuu = document.querySelector("#saveProductBtn");
                btnLuu.addEventListener("click", (e) => {
                    e.preventDefault();
                    //gán lại dữ liệu mới cho obj
                    product.id = productIdInput.value;
                    product.name = productNameInput.value;
                    product.desc = productDescInput.value;
                    product.price = productPriceInput.value;
                    product.idCate = productCateInput.value;
                    //Lấy ra tên sau khi được gán mới
                    var option = productCateInput.querySelector(`option[value="${product.idCate}"]`);
                    product.nameCate = option.innerHTML;
                    product.img = productImgInput.files[0].name;

                    //console.log(product);
                    formEdit.classList.remove('show');
                  
                    updateCategory(product);
                });
            };

        });

        close.onclick = function () {
            var formEdit = document.querySelector('#editProductModal');
            formEdit.classList.remove('show');
        }
    </script>--%>

    <script>
        //Xóa sản phẩm
        function btnXoa(obj, id, e) {
            e.preventDefault();
            var idElement = obj.id;
            var arr = idElement.split("_");
            var action = arr[0];
            var id_Product = arr[1];
            
            var data = {
                action: action,
                id: id_Product
            }
            console.log(idElement);
            if (confirm("Bạn có chắc muốn xóa?")) {
                const url = "AdminProductList.aspx?id=" + id + "&act=" + action;

                const xhttp = new XMLHttpRequest();
                xhttp.onreadystatechange = function () {
                    if (this.readyState == 4 && this.status == 200) {
                        console.log(this.responseText);
                        // Xóa hàng chứa sản phẩm khỏi bảng hiển thị
                        var tr = obj.parentNode.parentNode; // Thẻ <tr> cha của button
                        var idSanPham = tr.getAttribute("data-id"); // Lấy giá trị của thuộc tính data-id
                        var tbody = tr.parentNode; // Thẻ <tbody> cha của <tr>
                        tbody.removeChild(tr); // Xóa <tr> khỏi <tbody>
                    }
                }
                xhttp.open("get", url);
                xhttp.send();
            }
            else {
                // Không xóa
            }
        }
    </script>
</asp:Content>
