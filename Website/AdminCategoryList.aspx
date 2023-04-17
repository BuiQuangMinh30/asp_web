<%@ Page Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminCategoryList.aspx.cs" Inherits="Website.AdminCategoryList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="admin-content-right">
        <div class="admin-content-right-cartegory_list">
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
                            <td><%# Eval("iDanhMucId") %></td>
                            <td><%# Eval("sTenDanhMuc") %></td>
                            <td><%# Eval("sMoTa") %></td>
                            <td><%# Eval("dThoiGianTao", "{0:dd/MM/yyyy}") %></td>
                           <%-- <td><a href="#">Sửa</a>|<a href="#">Xóa</a></td>--%>
                            <td><button id="btnXoa_<%# Eval("iDanhMucId") %>" onclick="xoaDanhMuc(this, <%# Eval("iDanhMucId") %>, event)">Xóa</button></td>
                        </tr>
                    </ItemTemplate>
              </asp:ListView>
        </div>
    </div>
    <script>
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
                const url = "AdminCategoryList.aspx?id=" + idDanhMuc + ""
                xhttp.open("POST", url, true);
                xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                xhttp.send();
            }
        }
    </script>
</asp:Content>