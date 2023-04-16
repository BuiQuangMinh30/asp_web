<%@ Page Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminProduct.aspx.cs" Inherits="Website.AdminProducts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="admin-content-right">
        <div class="admin-content-right-product_add">
            <h1>Thêm sản phẩm</h1>
            <div>
                <label for="">Nhập tên sản phẩm<span style="color: red;">*</span></label>
                <input name="product_name" type="text">
                <label for="">Chọn danh mục<span style="color: red;">*</span></label>
                <select name="cartegory_id" id="cartegory_id">
                    <option value="#">--Chọn--</option>
                    <asp:ListView ID="lvDanhMuc" runat="server">
                        <ItemTemplate>
                            <option value="<%# Eval("iDanhMucId") %>"><%# Eval("sTenDanhMuc")  %></option>
                        </ItemTemplate>
                    </asp:ListView>
                </select>
                <label for="">Giá sản phẩm<span style="color: red;">*</span></label>
                <input name="product_price"  type="text">
                <label for="">Mô tả sản phẩm<span style="color: red;">*</span></label>
                <textarea name="product_desc" id="editor1" cols="30" rows="10"></textarea>
                <label for="">Ảnh sản phẩm<span style="color: red;">*</span></label>
                <asp:FileUpload ID="FileUpload1" runat="server" />
                <asp:Image ID="txtImage"  runat="server"/>
                <asp:Button CssClass="btn_submit" ID="btnAdd_Product" runat="server" Text="Thêm" onclick="btnAdd_Product_Click"/>
            </div>
        </div>
    </div>
</asp:Content>