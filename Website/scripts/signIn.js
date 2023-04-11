const showErrorStyles = (container, inputBox) => {
    container.classList.add("error");
    inputBox.classList.add("error");
    container.classList.remove("allow");
    inputBox.classList.remove("allow");
}
const removeErrorStyles = (container, inputBox) => {
    container.classList.remove("error");
    inputBox.classList.remove("error");
    container.classList.add("allow");
    inputBox.classList.add("allow");
}

const usernameValidate = () => {
    const usernameContainer = document.querySelector(".sign-in-username");
    const usernameInputBox = document.querySelector(".input-username");
    const usernameMessage = document.querySelector(".username-message");
    let username = usernameInputBox.value;

    /*Remove white space*/
    username = username.replaceAll(" ", "");

    if (username === "") {
        showErrorStyles(usernameContainer, usernameInputBox);
        usernameMessage.innerHTML = "Hãy điền tên tài khoản";
    }
    else {
        removeErrorStyles(usernameContainer, usernameInputBox);
        usernameMessage.innerHTML = "";
    }
}

const passwordValidate = () => {
    const passwordContainer = document.querySelector(".sign-in-password");
    const passwordInputBox = document.querySelector(".input-password");
    const passwordMessage = document.querySelector(".password-message");
    const password = passwordInputBox.value;

    if (password === "") {
        showErrorStyles(passwordContainer, passwordInputBox);
        passwordMessage.innerHTML = "Hãy điền mật khẩu";
    }
    else if (password.length <= 5) {
        showErrorStyles(passwordContainer, passwordInputBox);
        passwordMessage.innerHTML = "Mật khẩu phải lớn hơn 5 ký tự";
    }
    else {
        removeErrorStyles(passwordContainer, passwordInputBox);
        passwordMessage.innerHTML = "";
    }
}

const showPassword = showPasswordButton => {
    const passwordInputBox = document.querySelector(".input-password");

    if (passwordInputBox.getAttribute("type") == "password") {
        passwordInputBox.setAttribute("type", "text");
        showPasswordButton.innerHTML = "Ẩn password";
    }
    else {
        passwordInputBox.setAttribute("type", "password");
        showPasswordButton.innerHTML = "Hiển thị password";
    }
}


const addEvent = (() => {
    const inputBoxes = document.querySelectorAll("[class*='input-']");
    const showPasswordButton = document.getElementById("show-psw-btn");
    const submitButton = document.querySelector(".submit-button");

    inputBoxes[0].addEventListener("blur", () => {
        usernameValidate();
    });
    inputBoxes[1].addEventListener("blur", () => {
        passwordValidate();
    });

    showPasswordButton.addEventListener("click", () => {
        showPassword(showPasswordButton);
    });

    submitButton.addEventListener("click", e => {
        usernameValidate();
        passwordValidate();

        const errorMessage = document.querySelector("input.error");
        if (errorMessage) {
            e.preventDefault();
        }
    });
})();


    //var today = new Date();
    //var date = today.getDate() + '-' + (today.getMonth() + 1) + '-' + today.getFullYear();
    //var time = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
    //var dateTime = date + ' ' + time;
    //document.getElementById("hvn").innerHTML = dateTime;