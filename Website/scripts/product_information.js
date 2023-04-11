const sizeButtonSelected = (() => {
    const sizeButtons = document.querySelectorAll(".size-btn");
    sizeButtons.forEach(button => {
        button.addEventListener("click", () => {
            const sizeButtonPreviousSelected = document.querySelector(".size-btn.active");
            if (sizeButtonPreviousSelected) sizeButtonPreviousSelected.classList.remove("active");
            button.classList.add("active");
        });
    });
})();