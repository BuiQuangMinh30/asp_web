<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="signIn.aspx.cs" Inherits="Website.signIn" %>

    <!DOCTYPE aspx>

    <aspx xmlns="http://www.w3.org/1999/xaspx">

        <head runat="server">
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <link rel="stylesheet" href="./styles/global.css">
            <link rel="stylesheet" href="./styles/signUp-In.css">
            <link rel="preconnect" href="https://fonts.gstatic.com">
            <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;700&display=swap" rel="stylesheet">
            <title>Đăng nhập</title>
        </head>

        <body>
            <form id="form1" runat="server">
                <div class="header">
                    <div class="header__top">
                        <div class="header__phone">
                            <img src="./Images/Icons/Phone.png" alt="">
                            <p>012-345-6789</p>
                        </div>
                        <div class="header__user-menu">
                            <ul class="header__user-menu-desktop" runat="server" id="login_status_desktop">
                                <!-- If not logged in -->
                                <li><a href="signIn.aspx">Đăng nhập</a></li>
                                <span>|</span>
                                <!-- If logged in change signIn to username and signUp to Log Out  -->
                                <li><a href="signUp.aspx">Đăng xuất</a></li>
                            </ul>

                            <ul class="header__user-menu-mobile" runat="server" id="login_status_mobile">
                                <!-- If not logged in -->
                                <li><a href="signIn.aspx">Đăng nhập</a></li>
                                <span>|</span>
                                <li><a href="signUp.aspx">Đăng xuất</a></li>
                                <!-- If logged in change signIn to username, signUp to icon, delete span -->
                                <!-- Display in server side aspx -->
                                <!-- <li class="signOut-mobile"><a href="signOut.aspx"><img src="./Images/Icons/LogOut.svg" alt=""></a></li> -->
                            </ul>
                        </div>
                    </div>
                    <div class="header__main">
                        <div class="header__logo">
                            <a class="logo" href="IndexDefault.aspx"><img src="./Images/Logo.png" alt=""></a>
                            <a class="brand" href="IndexDefault.aspx">
                                PETSHOP
                            </a>
                        </div>
                        <div class="header__menu">
                            <ul>
                                <asp:ListView ID="listDanhMuc" runat="server">
                                    <ItemTemplate>
                                        <li><a href="All_ProductsDefault.aspx?idDanhMuc=<%# Eval("iDanhMucId") %>&type=<%# Eval("sTenDanhMuc") %>"><%# Eval("sTenDanhMuc") %></a></li>
                                    </ItemTemplate>
                                </asp:ListView>
                            </ul>
                        </div>

                        <div class="header__icons">
                            <%--<div class="header__search">
                                <img src="./Images/Icons/Search.png" alt="">
                                <input type="text" name="search" placeholder="Search" runat="server" id="search_text">
                                <button type="button" runat="server" id="search_button" onserverclick="SearchButton_Click">Tìm</button>
                            </div>--%>

                            <div class="header__cart">
                                <div class="cart__status">
                                    <p class="cart__number" runat="server" id="Cart_Total_Products">0</p>
                                </div>
                                <a href="CartDefault.aspx">
                                    <img src="./Images/Icons/Cart.svg" alt="">
                                </a>
                            </div>
                        </div>

                        <div class="header__mobile">
                            <div class="mobile__menu">
                                <div class="header__cart-mobile">
                                    <div class="cart__status">
                                        <p class="cart__number" runat="server" id="Cart_Total_Products_Mobile">0</p>
                                    </div>
                                    <a href="cart.aspx">
                                        <img src="./Images/Icons/Cart.svg" alt="">
                                    </a>
                                </div>
                                <div class="mobile__menu-burger">
                                    <div class="line-1"></div>
                                    <div class="line-2"></div>
                                    <div class="line-3"></div>
                                </div>
                            </div>
                            <div class="mobile__sub-menu">
                                <!-- Copy from above, inherited all the styles -->
                                <div class="header__menu-mobile">
                                    <ul>
                                        <li><a href="All_ProductsDefault?type=nike">Nike</a></li>
                                        <li><a href="All_ProductsDefault?type=adidas">Adidas</a></li>
                                        <li><a href="All_ProductsDefault?type=puma">Puma</a></li>
                                    </ul>
                                </div>
                                <div class="header__icons-mobile">
                                    <div class="header__search-mobile">
                                        <img src="./Images/Icons/Search.png" alt="">
                                        <input type="text" name="search" placeholder="Search" runat="server" id="search_text_mobile">
                                        <button type="button" runat="server" id="search_button_mobile" onserverclick="SearchButton_Click">Tìm</button>
                                    </div>
                                </div>
                                <!-- End of copy -->
                            </div>
                        </div>
                    </div>
                </div>

                <div class="sign-in-page-content">
                    <div class="form-wrapper">
                        <h1>Đăng nhập</h1>
                        <div class="form">
                            <div class="sign-in-username">
                                <input type="text" name="input-username" class="input-username" runat="server" id="txtTaiKhoan" placeholder="Tài Khoản*">
                                <p class="message username-message" runat="server" id="username_message"></p>
                            </div>
                            <div class="sign-in-password">
                                <input type="password" name="input-password" class="input-password" runat="server" id="txtMatKhau" placeholder="Password*">
                                <p class="message password-message" runat="server" id="password_message"></p>
                            </div>
                            <div class="show-password">
                                <label for="show-psw-btn">
                                    <img src="./Images/Icons/Eye.svg" alt="">
                                </label>
                                <button type="button" id="show-psw-btn">Hiển thị password</button>
                            </div>
                            <%--<div style="color:red;">
                                <p>date</p>
                                <p id="hvn" </p>
                            </div>--%>
                            <div class="sign-in-submit">
                                <p class="sign-in-status" runat="server" id="sign_in_status"></p>
                              <%-- <button type="submit" class="submit-button">Đăng Nhập</button>--%>
                              <asp:Button ID="btndangnhap" CssClass="submit-button" runat="server" Text="Đăng nhập" OnClick="btndangnhap_Click" />
                            </div>
                        </div>
                    </div>
                </div>
            </form>

            <script src="./scripts/global.js"></script>
            <script src="./scripts/signIn.js"></script>
        </body>
    </aspx>