<%@ Page Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminListCart.aspx.cs" Inherits="Website.AdminListCart" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="admin-content-right">
        <div class="admin-content-right-cartegory_list">
            <h1>Danh sách order</h1>
            <table>
                <tr>
                    <%--<th>ID</th>--%>
                    <th>Tên khách hàng</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Phương thức thanh toán</th>
                    <th>Địa chỉ giao</th>
                    <th>Ngày đặt</th>
                    <th>Tổng tiền</th>
                    <th>Trạng thái đơn hàng</th>
                    <th>Tùy biến</th>
                </tr>
                <asp:ListView ID="listProduct" runat="server">
                    <ItemTemplate>
                         <tr data-id="<%# Eval("iKhachHangId") %>">
                            <td><%# Eval("sTenKhachHang") %></td>
                            <td><%# Eval("sEmail") %></td>
                             <td><%# Eval("sPhone") %></td>
                            <td><%# Eval("sPhuongThucThanhToan") %></td>
                            
                            <td><%# Eval("sDiaChiGiao") %></td>
                             <td><%# Eval("dNgayDat", "{0:dd/MM/yyyy}") %></td>
                            <td><%# Eval("fTongTien") %></td>
                            <td id="trangthai"><%# ConvertNumberToWord((int)Eval("iTrangThai")) %></td>
                          <td>
                              <a class="products__button" href="AdminCartDetail.aspx?id=<%# Eval("iDonHangId") %>">Chi tiết</a>
                              <button class="admin-edit-button"  id="btnChangeTrangThai_<%# Eval("iDonHangId") %>" onclick="btnChangeTrangThai(this, <%# Eval("iDonHangId") %>, event)">Update trạng thái</button></td>
                        </tr>
                    </ItemTemplate>
              </asp:ListView>
            </table>
            <div class="pager">
                 <asp:DataPager ID="DataPager1" runat="server" PagedControlID="listProduct" PageSize="10">
                    <Fields>
                        <asp:NumericPagerField ButtonType="Link"/>
                        <asp:NextPreviousPagerField NextPageText="Tiếp" PreviousPageText="Trước" LastPageText="Cuối" ShowLastPageButton="True" ShowFirstPageButton="True" FirstPageText="Đầu"/>
                    </Fields>
                 </asp:DataPager>
            </div>
        </div>
    </div>
    <script>
        function btnChangeTrangThai(obj, id, e) {
            e.preventDefault();
            var trangthai = document.getElementById("trangthai")
            if (confirm("Bạn có muốn update?")) {
                const url = "AdminListCart.aspx?id=" + id + "";

                const xhttp = new XMLHttpRequest();
                xhttp.onreadystatechange = function () {
                    if (this.readyState == 4 && this.status == 200) {
                        // Xóa hàng chứa sản phẩm khỏi bảng hiển thị
                        var tr = obj.parentNode.parentNode; // Thẻ <tr> cha của button
                        var idSanPham = tr.getAttribute("data-id"); // Lấy giá trị của thuộc tính data-id
                        var tbody = tr.parentNode; // Thẻ <tbody> cha của <tr>
                        console.log('tbody', tr, idSanPham)
                        
                        //tbody.removeChild(tr); // Xóa <tr> khỏi <tbody>
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
