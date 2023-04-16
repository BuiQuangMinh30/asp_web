<%@ Page Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminCategory.aspx.cs" Inherits="Website.CategoryAdmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="admin-content-right">
        <div class="admin-content-right-cartegory_add">
            <h1>Thêm danh mục</h1>
            <div class="form-wrapper">
                <label for="category_name">Nhập tên danh mục:</label>
                <input class="input-nameCategory" name="category_name" id="txtTenDanhMuc" type="text" placeholder="Nhập tên danh mục">
                <p class="message category_name-message error" runat="server" id="category_name"></p>
                <label for="category_description">Mô tả danh mục:</label>
                <textarea class="input-description" name="category_description" id="txtMoTa" cols="30" rows="10"></textarea>
                <p class="message description-message error" runat="server" id="description_message"></p>
                <%--<button class="btn_submit" type="submit" runat="server" id="Add_button" onserverclick="Add_button_ServerClick">Thêm</button>--%>
                <asp:Button ID="btnAdd" CssClass="btn_submit" runat="server" Text="Thêm" OnClick="btnAdd_Click" />
            </div>
        </div>
        <!--<div class="admin-content-right-cartegory_list">
            <h1>Danh sách danh mục sản phẩm</h1>
            <table>
                <tr>
                    <th>ID</th>
                    <th>Tên danh mục</th>
                    <th>Mô tả</th>
                    <th>Thời gian tạo</th>
                    <th>Tùy biến</th>
                </tr>
                <%--<asp:ListView ID="ListView1" runat="server">--%>
                <tr>
                    <td>1</td>
                    <td>Gà</td>
                    <td>Cái này ngon lắm</td>
                    <td>21/08/2001</td>
                    <td><a href="">Sửa</a>|<a href="">Xóa</a></td>
                </tr>
               <%-- </asp:ListView>--%>
            </table>
        </div>-->
    </div>
    <script src="scripts/adminCategory.js"></script>
</asp:Content>
