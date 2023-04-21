<%@ Page Title="" Language="C#" MasterPageFile="~/Default.Master" AutoEventWireup="true" CodeBehind="CheckouSuccess.aspx.cs" Inherits="Website.CheckouSuccess" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderSearch" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <head>
        <meta charset="UTF-8">
        <title>DONE</title>
        <style>
            .main h1 {
                text-align: center;

            }
           .main img {
                margin-top: 50px;
                margin-left: 650px;
            }
            .main {
                justify-content: center;
            }
            .main p {
                text-align: center;
            }
            .main input {
                margin-left: 650px;
            }
        </style>
    </head>
     <body>
        <div class="main">
            <img src="https://images.fpt.shop/unsafe/filters:quality(5)/fptshop.com.vn/uploads/images/tin-tuc/148929/Originals/tich_xanh_titktok_2.png" alt="" width="50px" height="50px">
            <h1>Đặt hàng thành công</h1>
            <p>Đơn hàng của quý khách đã được tiếp nhận. SHOPPET sẽ sớm liên hệ với quý khách để bàn giao sản phẩm, dịch vụ.<br/>Cảm ơn quý khách đã tin dùng sản phẩm của chúng tôi!</p>
            <input type="button" value="Trang chủ">
        </div>
    </body>
</asp:Content>
