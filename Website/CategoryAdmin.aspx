<%@ Page Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="CategoryAdmin.aspx.cs" Inherits="Website.CategoryAdmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="admin-content-right">
        <div class="admin-content-right-cartegory_add">
            <h1>Thêm danh mục</h1>
            <div class="form-wrapper">
                <label for="category_name">Nhập tên danh mục:</label>
                <input name="category_name" id="txtTenDanhMuc" type="text" placeholder="Nhập tên danh mục">
                <label for="category_description">Mô tả danh mục:</label>
                <textarea name="category_description" id="txtMoTa" cols="30" rows="10"></textarea>
                <span id="lblError"></span>
                <button type="button" runat="server" id="Add_button" onserverclick="Add_button_ServerClick">Thêm</button>
            </div>
        </div>
    </div>
</asp:Content>
