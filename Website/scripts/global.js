const openSubMenu = (() => {
    const mobileMenuBurger = document.querySelector(".mobile__menu-burger");
    const mobileSubMenu = document.querySelector(".mobile__sub-menu");
    mobileMenuBurger.addEventListener("click", () => {
        // Change menu style 
        const burgerLines = document.querySelectorAll("[class*='line-']");
        burgerLines.forEach(line => {
            line.classList.toggle("active");
        });
        // Open menu
        mobileSubMenu.classList.toggle("active");
    });
})();

const changeProductsImages = (() => {
    const whiteColor = document.querySelectorAll(".products__color--white");
    const blackColor = document.querySelectorAll(".products__color--black");
    const redColor = document.querySelectorAll(".products__color--red");
    const productsImageElement = document.querySelectorAll(".products__image");
    let defaultImagesSource = [];
    let imagesSourceHyphenPosition = [];
    let imagesSourceBeforeHyphen = [];

    productsImageElement.forEach(image => {
        defaultImagesSource = [...defaultImagesSource, image.getAttribute("src")];
    });
    defaultImagesSource.forEach(source => {
        // ex: "./Images/Nike/Nike_1-White.svg" -> "-" pos = 20
        imagesSourceHyphenPosition = [...imagesSourceHyphenPosition, source.indexOf("-")];
    });
    imagesSourceHyphenPosition.forEach((hyphenPos, index) => {
        //+1 include hyphen, ex: "./Images/Nike/Nike_1-White.svg" -> "./Images/Nike/Nike_1-"
        imagesSourceBeforeHyphen = [...imagesSourceBeforeHyphen, defaultImagesSource[index].substr(0, hyphenPos + 1)];
    });

    whiteColor.forEach((white, index) => {
        white.addEventListener("mouseover", () => {
            productsImageElement[index].setAttribute("src", `${imagesSourceBeforeHyphen[index]}White.svg`);
        });
    });

    blackColor.forEach((black, index) => {
        black.addEventListener("mouseover", () => {
            productsImageElement[index].setAttribute("src", `${imagesSourceBeforeHyphen[index]}Black.svg`);
        });
    });

    redColor.forEach((red, index) => {
        red.addEventListener("mouseover", () => {
            productsImageElement[index].setAttribute("src", `${imagesSourceBeforeHyphen[index]}Red.svg`);
        });
    });

})();