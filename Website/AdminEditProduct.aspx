<%@ Page Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminEditProduct.aspx.cs" Inherits="Website.AdminEditProduct" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <!-- The Modal -->
        <div id="editProductModal" style="display: block; z-index: 0; width: 80%; margin:0">
            <!-- Modal content -->
            <div class="modal-content form_wrapper" style="margin: 50px auto">
                <span class="close">&times;</span>
                <h2 style="text-align: center">Sửa sản phẩm</h2>
                <div class="edit-form">
                    <input type="hidden" name="productId"/>

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
                    <asp:FileUpload ID="FileUpload1" runat="server" />

                    <asp:Button ID="btnUpdate" runat="server" Text="Cập Nhập" OnClick="btnUpdate_Click"/>
                    <button id="cancelProductBtn" class="btn_submit" type="button">
                        <a href="AdminProductList.aspx">Hủy</a>
                    </button>
                </div>
            </div>
        </div>
</asp:Content>
