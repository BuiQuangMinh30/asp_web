const circleClick = (() => {
    const sliderButtons = Array.from(document.getElementsByClassName("slider__circle"));
    sliderButtons.forEach((button, currentIndex) => {
        button.addEventListener("click", () => {
            const sliderButtonActive = document.querySelector(".slider__circle.active")
            const imagesContainer = document.querySelector(".slider__images-container");
            let imagesContainerWidth = imagesContainer.offsetWidth;
            sliderButtonActive.classList.remove("active");
            button.classList.add("active");
            imagesContainer.style.transform = `translateX(-${imagesContainerWidth * currentIndex}px)`;
        });
    });
})();

const slideAutoPlay = (() => {
    const sliderButtons = Array.from(document.getElementsByClassName("slider__circle"));
    const imagesContainer = document.querySelector(".slider__images-container");
    let currentIndex = 0;
    setInterval(() => {
        let imagesContainerWidth = imagesContainer.offsetWidth;
        const sliderButtonActive = document.querySelector(".slider__circle.active")
        if (currentIndex == 2) currentIndex = -1;
        currentIndex++;
        sliderButtonActive.classList.remove("active");
        sliderButtons[currentIndex].classList.add("active");
        imagesContainer.style.transform = `translateX(-${imagesContainerWidth * currentIndex}px)`;
    }, 7500);
})();

const productsSlide = (() => {
    const productsLists = document.getElementsByClassName("products__slide-wrapper");
    let productsSlideWidth = document.querySelector(".products__slide").offsetWidth;
    const leftArrows = Array.from(document.getElementsByClassName("products__left-arrow"));
    const rightArrows = Array.from(document.getElementsByClassName("products__right-arrow"));
    let maxTimesToRight = [];
    let currentPosition = [];
    let productsWrapperWidth = document.querySelector(".products__wrapper").offsetWidth + 16; //Width+margin

    for (let i = 0; i < productsLists.length; ++i) {
        maxTimesToRight.push(Math.ceil((productsLists[i].offsetWidth - productsSlideWidth) / productsWrapperWidth));
        currentPosition.push(0);
    }

    //Recalculate when resize
    window.addEventListener("resize", () => {
        maxTimesToRight = [];
        productsWrapperWidth = document.querySelector(".products__wrapper").offsetWidth + 16; //Width+margin
        productsSlideWidth = document.querySelector(".products__slide").offsetWidth;
        //When shrinking, cannot click to the end of slide => Recalculate maxTimesToRight when resize
        for (let i = 0; i < productsLists.length; ++i) {
            maxTimesToRight.push(Math.ceil((productsLists[i].offsetWidth - productsSlideWidth) / productsWrapperWidth));
        }
    });

    //When shrinking, cannot click to the end of slide =>
    //Recalculate maxTimesToRight when resize
    window.addEventListener("resize", () => {
        for (let i = 0; i < productsLists.length; ++i) {
            maxTimesToRight[i] = (Math.ceil((productsLists[i].offsetWidth - productsSlideWidth) / productsWrapperWidth));
        }
    });

    //RightArrows event
    rightArrows.forEach((rightArrow, index) => {
        rightArrow.addEventListener("click", (event) => {
            if (currentPosition[index] == maxTimesToRight[index] - 1) rightArrow.classList.add("disable"); //Changing button color

            if (currentPosition[index] >= maxTimesToRight[index]) { } //Prevent curPos from going greater than max
            else {
                currentPosition[index]++;
                leftArrows[index].classList.remove("disable");
            }
            productsSlideToRight(productsLists[index], currentPosition[index], maxTimesToRight[index], productsWrapperWidth, event);
        });
    });

    //LeftArrows event
    leftArrows.forEach((leftArrow, index) => {
        if (currentPosition[index] == 0) leftArrow.classList.add("disable"); //Default
        leftArrow.addEventListener("click", (event) => {
            if (currentPosition[index] == 1) leftArrow.classList.add("disable"); //Changing button color

            if (currentPosition[index] <= 0) { } //Prevent curPos from going lower than 0
            else {
                currentPosition[index]--;
                rightArrows[index].classList.remove("disable");
            }
            productsSlideToRight(productsLists[index], currentPosition[index], maxTimesToRight[index], productsWrapperWidth, event);
        });
    });
})();

const productsSlideToRight = (productsList, currentPosition, maxTimesToRight, productsWrapperWidth, event) => {
    // console.log(currentPosition, maxTimesToRight);
    if (currentPosition > maxTimesToRight || currentPosition < 0) {
        event.preventDefault();
    }
    else {
        productsList.style.transform = `translateX(-${productsWrapperWidth * currentPosition}px)`;
    }
}