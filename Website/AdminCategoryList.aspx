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
                         <tr>
                            <td><%# Eval("iDanhMucId") %></td>
                            <td><%# Eval("sTenDanhMuc") %></td>
                            <td><%# Eval("sMoTa") %></td>
                            <td><%# Eval("dThoiGianTao", "{0:dd/MM/yyyy}") %></td>
                            <td><a href="#">Sửa</a>|<a href="#">Xóa</a></td>
                        </tr>
                    </ItemTemplate>
              </asp:ListView>
        </div>
    </div>
</asp:Content>