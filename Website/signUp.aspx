<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="signUp.aspx.cs" Inherits="Website.signUp" %>

    <!DOCTYPE html>

    <html xmlns="http://www.w3.org/1999/xhtml">

    <head runat="server">
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="./styles/global.css" />
        <link rel="stylesheet" href="./styles/signUp-In.css" />
        <link rel="preconnect" href="https://fonts.gstatic.com" />
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;700&display=swap" rel="stylesheet" />
        <title>Đăng ký</title>
    </head>

    <body>
        <form id="form1" runat="server" method="post">
            <div class="header">
                <div class="header__top">
                    <div class="header__phone">
                        <img src="./Images/Icons/Phone.png" alt="">
                        <p>012-345-6789</p>
                    </div>
                    <div class="header__user-menu">
                        <ul class="header__user-menu-desktop" runat="server" id="login_status_desktop">
                            <!-- If not logged in -->
                            <li><a href="signIn.aspx">Sign In</a></li>
                            <span>|</span>
                            <!-- If logged in change signIn to username and signUp to Log Out  -->
                            <li><a href="signUp.aspx">Sign Up</a></li>
                        </ul>

                        <ul class="header__user-menu-mobile" runat="server" id="login_status_mobile">
                            <!-- If not logged in -->
                            <li><a href="signIn.aspx">Sign In</a></li>
                            <span>|</span>
                            <li><a href="signUp.aspx">Sign Up</a></li>
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
                                    <li><a href="All_ProductsDefault.aspx?type=nike">Chó</a></li>
                                    <li><a href="All_ProductsDefault.aspx.aspx?type=adidas">Mèo</a></li>
                                    <li><a href="All_ProductsDefault.aspx.aspx?type=puma">Khác</a></li>
                                </ul>
                    </div>

                    <div class="header__icons">
                       <%-- <div class="header__search">
                            <img src="./Images/Icons/Search.png" alt="">
                            <input type="text" name="search" placeholder="Search" runat="server" id="search_text">
                            <button type="button" runat="server" id="search_button" onserverclick="SearchButton_Click">Tìm</button>
                        </div>--%>

                        <div class="header__cart">
                            <div class="cart__status">
                                <p class="cart__number" runat="server" id="Cart_Total_Products">0</p>
                            </div>
                            <a href="cart.aspx">
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
                                    <li><a href="All_ProductsDefault.aspx?type=nike">Chó</a></li>
                                    <li><a href="All_ProductsDefault.aspx.aspx?type=adidas">Mèo</a></li>
                                    <li><a href="All_ProductsDefault.aspx.aspx?type=puma">Khác</a></li>
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

            <div class="sign-up-page-content">
                <div class="form-wrapper">
                    <h1>Đăng ký</h1>
                    <div class="form">
                        <div class="sign-up-fullname">
                            <input type="text" name="input-fullname" class="input-fullname" placeholder="Họ và tên*">
                            <p class="message fullname-message" runat="server" id="fullname_message"></p>
                        </div>
                         <%--<div class="sign-up-username">
                            <input type="text" name="input-username" class="input-username" placeholder="Tài Khoản*">
                            <p class="message username-message" runat="server" id="username_message"></p>
                        </div>--%>
                        <div class="sign-up-address">
                            <input type="text" name="input-address" class="input-address" placeholder="Địa chỉ*">
                            <p class="message address-message" runat="server" id="address_message"></p>
                        </div>
                        <div class="sign-up-phone">
                            <input type="text" name="input-phone" class="input-phone" placeholder="Số điện thoại*">
                            <p class="message phone-message" runat="server" id="phone_message"></p>
                        </div>
                        <div class="sign-up-email">
                            <input type="text" name="input-email" class="input-email" placeholder="Email*">
                            <p class="message email-message" runat="server" id="email_message"></p>
                        </div>
                        <div class="sign-up-password">
                            <input type="password" name="input-password" class="input-password" placeholder="Password*">
                            <p class="message password-message" runat="server" id="password_message"></p>
                        </div>
                        <div class="sign-up-repassword">
                            <input type="password" name="input-repassword" class="input-repassword"
                                placeholder="Nhập lại Password*">
                            <p class="message repassword-message" runat="server" id="repassword_message"></p>
                        </div>
                        <div class="show-password">
                            <label for="show-psw-btn">
                                <img src="./Images/Icons/Eye.svg" alt="">
                            </label>
                            <button type="button" id="show-psw-btn">Hiển thị password</button>
                        </div>
                        <div class="sign-up-submit">
                            <p class="sign-up-status" runat="server" id="sign_up_status"></p>
                          <%-- <button type="submit" class="submit-button">Đăng ký</button>--%>
                           <asp:Button ID="btndangky" CssClass="submit-button" runat="server" Text="Đăng ký" OnClick="btndangky_Click"/>
                        </div>
                    </div>
                </div>
            </div>
        </form>

        <script src="./scripts/global.js"></script>
        <script src="./scripts/signUp.js"></script>
    </body>

    </html>