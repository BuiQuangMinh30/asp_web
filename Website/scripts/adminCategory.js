var $ = document.querySelector.bind(document);
var $$ = document.querySelectorAll.bind(document);

const nameCategoryValidate = () => {
    const nameCategoryMessage = $(".category_name-message");
    const nameCategoryInput = $(".input-nameCategory")
    const nameCategory = nameCategoryInput.value.trim();

    console.log(nameCategoryMessage);
    console.log(nameCategoryInput);
    if (nameCategory === "") {
        nameCategoryMessage.innerHTML = "Hãy điền tên danh mục";
        return false;
    }
    else {
        nameCategoryMessage.innerHTML = "";
        return true;
    }
}

const descriptionValidate = () => {
    const descriptionMessage = $(".description-message");
    const descriptionInput = $(".input-description")
    const description = descriptionInput.value.trim();

    if (description === "") {
        descriptionMessage.innerHTML = "Hãy điền mô tả cho danh mục";
        return false;
    }
    else {
        descriptionMessage.innerHTML = "";
        return true;
    }
}

//const addEvents = (() => {
const submitButton = document.querySelector(".btn_submit");
//    const descriptionMessage = $(".description-message");
//    const nameCategoryMessage = $(".category_name-message");
//    submitButton.onclick = (e) => {

//        //const errorMessage = document.querySelector("p.error");
//        //const error = errorMessage.innerHTML;
//        //if (error!="") {
//        //    e.preventDefault();
//        //}

//        if (nameCategoryValidate()) {
//            nameCategoryMessage.innerHTML = "Hãy điền tên danh mục";
//            e.preventDefault();
//        }
//        if (descriptionValidate()) {
//            descriptionMessage.innerHTML = "Hãy điền mô tả cho danh mục";
//            e.preventDefault();
//        }
//    }

//})();

submitButton.onclick = (e) => {
    let isValid = true;
    if (!nameCategoryValidate()) {
        isValid = false;
    }
    if (!descriptionValidate()) {
        isValid = false;
    }
    if (!isValid) {
        e.preventDefault();
    }
}