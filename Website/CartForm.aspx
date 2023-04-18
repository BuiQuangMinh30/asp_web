<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="CartForm.aspx.cs" Inherits="Website.CartForm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
	 <link rel="stylesheet" href="./styles/form-cart.css">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

	<div id="content">
		 	<h2>Thông tin thanh toán</h2>
		 	
		 	<fieldset id="fieldset-billing">
		 		<legend>Hóa đơn</legend>
		 		<div>
		 			<label for="name">Họ tên</label>
		 			<input type="text" name="name" id="name"  />
		 		</div>
		 		<div>
		 			<label for="email">Email</label>
		 			<input type="email" name="email" id="email"  />
		 		</div>
		 		<div>
		 			<label for="number">Số điện thoại</label>
		 			<input type="number" name="phone" id="number"  />
		 		</div>
		 		<div>
		 			<label for="address">Địa chỉ giao hàng</label>
		 			<input type="text" name="address" id="address"  />
		 		</div>
		 		<div>
		 			<label for="code">Mã giảm giá</label>
		 			<input type="text" name="zip" id="code"  />
		 		</div>
		 		<%--<div>
		 			<label for="type">Hình thức thanh toán</label>
		 			<select name="country" id="country" >
		 				<option value="">Thanh toán khi nhận hàng</option>
		 				<option value="IN">Thanh toán chuyển khoản</option>
		 			</select>
		 		</div>--%>
		 	</fieldset>
		 	
		 
		 	
		 	<asp:Button CssClass="btn_submit" ID="btnAdd_Cart" runat="server" Text="Thêm" OnClick="btnAdd_Cart_Click" />
		 
	</div>
	
	

</asp:Content>
