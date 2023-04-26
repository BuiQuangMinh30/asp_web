<%@ Page Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminEditProduct.aspx.cs" Inherits="Website.AdminEditProduct" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- The Modal -->
    <div id="editProductModal" style="display: block; z-index: 0; width: 80%; margin: 0">
        <!-- Modal content -->
        <div class="modal-content form_wrapper" style="margin: 50px auto">
            <span class="close">&times;</span>
            <h2 style="text-align: center">Sửa sản phẩm</h2>
            <div class="edit-form">

                <label for="categoryName">Tên danh mục<span style="color: red;">*</span></label>
                <select name="categoryName">
                    <asp:ListView ID="ListView1" runat="server">
                        <ItemTemplate>
                            <option class="option" value="<%# Eval("iDanhMucId") %>"><%# Eval("sTenDanhMuc") %></option>
                        </ItemTemplate>
                    </asp:ListView>
                </select>
                <asp:ListView ID="ListView2" runat="server">
                    <ItemTemplate>
                         <input type="hidden" name="productIdDanhMuc" value="<%# Eval("iDanhMucId") %>""/>
                            
                        <label for="productName">Tên sản phẩm<span style="color: red;">*</span></label>
                        <input type="text" id="productName" name="productName" value="<%# Eval("sTenSanPham") %>">

                        <label for="productPrice">Đơn giá sản phẩm<span style="color: red;">*</span></label>
                        <input type="text" id="productPrice" name="productPrice" value="<%# Eval("fDonGia") %>">

                        <label for="productDesc">Mô tả sản phẩm<span style="color: red;">*</span></label>
                        <textarea type="text" id="productDesc" name="productDesc" value="" cols="30" rows="10"><%# Eval("sMoTa") %></textarea>

                    </ItemTemplate>
                </asp:ListView>
                <label for="productImg">Ảnh mới<span style="color: red;">*</span></label>
                <asp:FileUpload ID="FileUpload1" runat="server"/>

                <asp:Button ID="btnUpdate" runat="server" Text="Cập Nhập" OnClick="btnUpdate_Click" />
                <button id="cancelProductBtn" class="btn_submit" type="button">
                    <a href="AdminProductList.aspx">Hủy</a>
                </button>
            </div>
        </div>
    </div>
    <script>
        var categoryId = document.querySelector('input[name="productIdDanhMuc"]').value;
        // Lấy thẻ select
        var select = document.querySelector('select[name="categoryName"]');
        //var options = select.querySelectorAll(".option");
       
        // Lặp qua các tùy chọn trong select
        for (var i = 0; i < select.options.length; i++) {
            // Nếu giá trị tùy chọn bằng với id danh mục của sản phẩm
            if (select.options[i].value == categoryId) {
                // Chọn tùy chọn này
                select.options[i].selected = true;
                break;
            }
        }
    </script>
</asp:Content>
