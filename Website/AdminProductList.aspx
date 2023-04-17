<%@ Page Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminProductList.aspx.cs" Inherits="Website.AdminProductList" %>
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
                            <td><%# Eval("sTenDanhMuc") %></td>
                            <td><%# Eval("sTenSanPham") %></td>
                            <td><%# Eval("fDonGia") %></td>
                            <td><%# Eval("sMoTa") %></td>
                            <%--<td><%# Eval("sAnh") %></td>--%>
                            <td><image width="70px" height="70px" src="<%# Eval("sAnh") %>" alt="" /></td>
                            <td><%# Eval("dThoiGianTao", "{0:dd/MM/yyyy}") %></td>
                          <%--  <td><a href="#">Sửa</a>|<a href="#">Xóa</a></td>--%>
                            <td><button id="btnXoa_<%# Eval("iSanPhamId") %>" onclick="btnXoa(this, <%# Eval("iSanPhamId") %>, event)">Xóa</button></td>
                        </tr>
                    </ItemTemplate>
              </asp:ListView>
            </table>
            <div class="pager">
                 <asp:DataPager ID="DataPager1" runat="server" PagedControlID="listProduct" PageSize="9">
                    <Fields>
                        <asp:NumericPagerField ButtonType="Link"/>
                        <asp:NextPreviousPagerField NextPageText="Tiếp" PreviousPageText="Trước" LastPageText="Cuối" ShowLastPageButton="True" ShowFirstPageButton="True" FirstPageText="Đầu"/>
                    </Fields>
                 </asp:DataPager>
            </div>
        </div>
    </div>
    <script>
        function btnXoa(obj, id, e) {
            e.preventDefault();
            console.log(obj);
            if (confirm("Bạn có chắc muốn xóa?")) {
                const url = "AdminProductList.aspx?id=" + id + "";

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
