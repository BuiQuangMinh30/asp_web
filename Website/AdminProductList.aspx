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
                         <tr>
                            <td><%# Eval("iSanPhamId") %></td>
                            <td><%# Eval("sTenDanhMuc") %></td>
                            <td><%# Eval("sTenSanPham") %></td>
                            <td><%# Eval("fDonGia") %></td>
                            <td><%# Eval("sMoTa") %></td>
                            <%--<td><%# Eval("sAnh") %></td>--%>
                            <td><image width="70px" height="70px" src="<%# Eval("sAnh") %>" alt="" /></td>
                            <td><%# Eval("dThoiGianTao", "{0:dd/MM/yyyy}") %></td>
                            <td><a href="#">Sửa</a>|<a href="#">Xóa</a></td>
                        </tr>
                    </ItemTemplate>
              </asp:ListView>
        </div>
    </div>
</asp:Content>
