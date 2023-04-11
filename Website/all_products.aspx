<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="all_products.aspx.cs" Inherits="Website.all_products" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./styles/global.css">
    <link rel="stylesheet" href="./styles/products_wrapper.css">
    <link rel="stylesheet" href="./styles/all_products.css">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;700&display=swap" rel="stylesheet">
    <title>Tất cả sản phẩm</title>
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
                    <a class="logo" href="index.aspx"><img src="./Images/Logo.png" alt=""></a>
                    <a class="brand" href="index.aspx">
                        PETSHOP
                    </a>
                </div>
                <div class="header__menu">
                    <ul>
                        <li><a href="all_products.aspx?type=dog">Chó</a></li>
                        <li><a href="all_products.aspx?type=cat">Mèo</a></li>
                        <li><a href="all_products.aspx?type=diff">Khác</a></li>
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
                                <li><a href="all_products.aspx?type=dog">Chó</a></li>
                                <li><a href="all_products.aspx?type=cat">Mèo</a></li>
                                <li><a href="all_products.aspx?type=diff">Khác</a></li>
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

        <div class="all-products-page-content">
            <%--<div class="filter">
                <h3 class="filter__heading">Bộ lọc</h3>
                <ul class="filter__list">
                    <li class="filter__item"><a href="#" runat="server" id="Filter_01">&le; 1 triệu</a></li>
                    <li class="filter__item"><a href="#" runat="server" id="Filter_02">1 - 3 triệu</a></li>
                    <li class="filter__item"><a href="#" runat="server" id="Filter_03">&ge; 3 triệu</a></li>
                </ul>
            </div>--%>
            <div class="all-products">
                <div class="all-products_heading">
                    <h2 class="all-products_brand-name" runat="server" id="all_products_brand_name"></h2>
                </div>
                <div class="all-products__container">
                    <asp:ListView ID="ListViewAllProducts" runat="server">
                        <ItemTemplate>
                            <div class="products__wrapper">
                                <a href="product_information.aspx?id=<%# Eval("id") %>">
                                    <img class="products__image" src="<%# Eval("img") %>" alt="">
                                </a>
                                <div class="products__content">
                                    <h3 class="products__name"><%# Eval("name") %></h3>
                                    <%--<div class="products__colors">
                                        <div class="products__color--white"></div>
                                        <div class="products__color--black"></div>
                                        <div class="products__color--red"></div>
                                    </div>--%>
                                    <p class="products__price">Giá: <%# Eval("price") %><span class="products__price-unit">đ</span></p>
                                    <a class="products__button" href="product_information.aspx?id=<%# Eval("id") %>">Chi tiết</a>
                                </div>
                            </div>   
                        </ItemTemplate>
                    </asp:ListView>
                </div>
            </div>
        </div>

        <div class="footer">
            <div class="footer__contact">
                <p>Số điện thoại: 091.333.333</p>
                <p>Email: PetShop@gmail.com</p>
            </div>
            <div class="footer__branch">
                <p>Chi nhánh 1: 96 Định Công - Hà Nội</p>
                <p>Chi nhánh 2: 96 Định Công - Hà Nội</p>
            </div>
            <div class="footer__social">
                <a href="https://www.facebook.com/171O2O17/" target="_blank"><img src="./Images/Social/Facebook.svg"
                        alt=""></a>
                <a href="#"><img src="./Images/Social/Twitter.svg" alt=""></a>
                <a href="#"><img src="./Images/Social/Instagram.svg" alt=""></a>
            </div>
        </div>
    </form>

    <script src="./scripts/global.js"></script>
</body>
</html>
