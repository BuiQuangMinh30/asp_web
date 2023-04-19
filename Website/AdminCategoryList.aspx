<%@ Page Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminCategoryList.aspx.cs" Inherits="Website.AdminCategoryList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="admin-content-right">
        <div class="admin-content-right-cartegory_list">
            <div class="list-category-form">
                <h1>Danh sách danh mục sản phẩm</h1>
                <table>
                    <tr>
                        <th>ID</th>
                        <th>Tên danh mục</th>
                        <th>Mô tả</th>
                        <th>Thời gian tạo</th>
                        <th>Tùy biến</th>
                    </tr>
                    <asp:ListView ID="listDanhMuc" runat="server">
                        <ItemTemplate>
                             <tr data-id="<%# Eval("iDanhMucId") %>">
                                <td class="productId"><%# Eval("iDanhMucId") %></td>
                                <td class="productName"><%# Eval("sTenDanhMuc") %></td>
                                <td class="productDescription"><%# Eval("sMoTa") %></td>
                                <td class="productDate"><%# Eval("dThoiGianTao", "{0:dd/MM/yyyy}") %></td>
                                <td>
                                    <button class="admin-edit-button" id="sua_<%# Eval("iDanhMucId") %>" onclick="suaDanhMuc(this, <%# Eval("iDanhMucId") %>, event)">Sửa</button>
                                    <button class="admin-delete-button" id="xoa_<%# Eval("iDanhMucId") %>" onclick="xoaDanhMuc(this, <%# Eval("iDanhMucId") %>, event)">Xóa</button>
                                </td>
                            </tr>
                        </ItemTemplate>
                  </asp:ListView>
                </table>
                <div class="pager">
                     <asp:DataPager ID="DataPager1" runat="server" PagedControlID="listDanhMuc" PageSize="10">
                        <Fields>
                            <asp:NumericPagerField ButtonType="Link"/>
                            <asp:NextPreviousPagerField NextPageText="Tiếp" PreviousPageText="Trước" LastPageText="Cuối" ShowLastPageButton="True" ShowFirstPageButton="True" FirstPageText="Đầu"/>
                        </Fields>
                     </asp:DataPager>
                </div>
            </div>
           
            <div class="edit-category-form">
                <h1>Sửa danh mục sản phẩm</h1>
                <div class="form_wrapper">
                    <input type="hidden" name="category-id" value="">
                    <label for="category-name">Tên danh mục<span style="color: red;">*</span></label>
                    <input type="text" name="category-name" value="">
                    <label for="category-description">Mô tả sản phẩm<span style="color: red;">*</span></label>
                    <textarea type="text" name="category-description" value="" cols="30" rows="10"></textarea>
                    <button id="btnLuu" class="btn_submit">Lưu</button>
                    <button id="btnHuy" class="btn_submit">Hủy</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        //Bật, tắt hiện formEdit
        document.querySelector(".edit-category-form").style.display = "none";
       
        //Xử lý sửa danh mục

        //Gửi yêu cầu lên server bằng Ajax
        function updateCategory(category) {
            var xhttp = new XMLHttpRequest();
            xhttp.onreadystatechange = function () {
                if (this.readyState == 4 && this.status == 200) {
                    // Nhận phản hồi từ server và xử lý dữ liệu trả về ở đây
                    var result = JSON.parse(this.responseText);
                    //console.log(result);
                    alert(result.d);
                    updateRowOnTable(category);
                }
            };
            xhttp.open("POST", "AdminCategoryList.aspx/suaDanhMuc", true);
            xhttp.setRequestHeader("Content-type", "application/json");
            var data = JSON.stringify(category);
            //console.log(data);
            xhttp.send(data);
        }

        //Hàm cập nhập dữ liệu khi nhận được phản hồi từ server
        function updateRowOnTable(category)
        {
            var row = document.querySelector("tr[data-id='" + category.id + "']");
            row.querySelector(".productName").innerHTML = category.name;
            row.querySelector(".productDescription").innerHTML = category.description;
        }
 
        //Sự kiện click nút Sửa
        function suaDanhMuc(obj,id, e)
        {
            document.querySelector(".list-category-form").style.display = "none";
            document.querySelector(".edit-category-form").style.display = "block";
            e.preventDefault();

            let formEdit = document.querySelector(".edit-category-form");
            var categoryIdInput = formEdit.querySelector('input[name="category-id"]');
            var categoryNameInput = formEdit.querySelector('input[name="category-name"]');
            var categoryDescriptionInput = formEdit.querySelector('textarea[name="category-description"]');
           
            var row = obj.closest("tr");
            var category = {
                id: row.getAttribute("data-id"),
                name: row.querySelector(".productName").innerHTML,
                description: row.querySelector(".productDescription").innerHTML
            };
            categoryIdInput.value = category.id;
            categoryNameInput.value = category.name;
            categoryDescriptionInput.value = category.description;

            
            //Sự kiện click nút lưu
            var btnLuu = document.querySelector("#btnLuu");
            btnLuu.addEventListener("click", (e) => {
                e.preventDefault();
                //gán lại dữ liệu mới cho obj
                category.id = categoryIdInput.value;
                category.name = categoryNameInput.value;
                category.description = categoryDescriptionInput.value;

                document.querySelector(".list-category-form").style.display = "block";
                document.querySelector(".edit-category-form").style.display = "none";
                //console.log(category);
                updateCategory(category);
            });

            //Hủy
            var btnCancel = document.querySelector("#btnHuy");
            btnCancel.addEventListener("click", function (e) {
                e.preventDefault();
                document.querySelector(".list-category-form").style.display = "block";
                document.querySelector(".edit-category-form").style.display = "none";
            });
        }


        //Xử lý xóa danh mục
        function loadCategoryList(obj) {
            var tr = obj.parentNode.parentNode; // Thẻ <tr> cha của button
            var idSanPham = tr.getAttribute("data-id"); // Lấy giá trị của thuộc tính data-id
            var tbody = tr.parentNode; // Thẻ <tbody> cha của <tr>
            tbody.removeChild(tr); // Xóa <tr> khỏi <tbody>
        }
        function xoaDanhMuc(obj, idDanhMuc, e) {
            e.preventDefault();
            //console.log(obj);
            if (confirm("Bạn có chắc muốn xóa category này?"))
            {
                var xhttp = new XMLHttpRequest();
                xhttp.onreadystatechange = function () {
                    if (this.readyState == 4 && this.status == 200) {
                        console.log(this.responseText);
                        var response = this.responseText;
                        if (response == "exists")
                        {
                            alert("Không thể xóa danh mục này vì đã được sử dụng trong sản phẩm!");
                        }
                        else if (response == "success")
                        {
                            alert("Xóa danh mục thành công!");
                            // Cập nhật danh sách category
                            loadCategoryList(obj);
                        }
                        else {
                            alert("Xóa danh mục không thành công!");
                        }
                    }
                };

                //id được truyền vào từ function 
                const url = "AdminCategoryList.aspx?id=" + idDanhMuc + ""
                xhttp.open("POST", url, true);
                xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                xhttp.send();
            }
        }
    </script>
</asp:Content>