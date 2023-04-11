// const inputBoxHasValue = (() => {
//     const inputBoxes = document.querySelectorAll("[class*='input-']");
//     inputBoxes.forEach(inputBox => {
//         inputBox.addEventListener("keyup", () => {
//             inputBox.value ? inputBox.classList.add("hasValue") : inputBox.classList.remove("hasValue");
//         });
//     });
// })();

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

const fullnameValidate = () => {
    const fullnameContainer = document.querySelector(".sign-up-fullname");
    const fullnameInputBox = document.querySelector(".input-fullname");
    const fullnameMessage = document.querySelector(".fullname-message");
    const fullname = fullnameInputBox.value;

    const containsNumber = () => {
        for (let i = 0; i < fullname.length; ++i) {
            if (!isNaN(parseInt(fullname[i]))) {
                return true;
                break;
            }
        }
        return false;
    }

    if (fullname === "") {
        showErrorStyles(fullnameContainer, fullnameInputBox);
        fullnameMessage.innerHTML = "Hãy điền Họ và tên";
    }
    else if (containsNumber()) {
        showErrorStyles(fullnameContainer, fullnameInputBox);
        fullnameMessage.innerHTML = "Họ và tên không được chứa số";
    }
    else {
        removeErrorStyles(fullnameContainer, fullnameInputBox);
        fullnameMessage.innerHTML = "";
    }
};

const usernameValidate = () => {
    const usernameContainer = document.querySelector(".sign-up-username");
    const usernameInputBox = document.querySelector(".input-username");
    const usernameMessage = document.querySelector(".username-message");
    let username = usernameInputBox.value;

    /*Remove white space*/
    username = username.replaceAll(" ", "");

    if (username === "") {
        showErrorStyles(usernameContainer, usernameInputBox);
        usernameMessage.innerHTML = "Hãy điền tên tài khoản";
    }
    else if (username.length < 8 || username.length > 12) {
        showErrorStyles(usernameContainer, usernameInputBox);
        usernameMessage.innerHTML = "Tài khoản chỉ chứa 8 đến 12 ký tự";
    }
    else {
        removeErrorStyles(usernameContainer, usernameInputBox);
        usernameMessage.innerHTML = "";
        //}
    }
}

const emailValidate = () => {
    const emailContainer = document.querySelector(".sign-up-email");
    const emailInputBox = document.querySelector(".input-email");
    const emailMessage = document.querySelector(".email-message");
    const email = emailInputBox.value;

    const countChar = (string, char) => {
        let count = 0;
        for (let i = 0; i < string.length; ++i) {
            if (string[i] === char) count++;
        }
        return count;
    }

    const check = () => {
        // Contains '@' and '.'
        if (email.indexOf(".") === -1 && email.indexOf("@") === -1) return -1;
        else if (email.indexOf("@") === -1) return -2;
        else if (email.indexOf(".") === -1) return -3;
        // More than 1 '@'
        else if (countChar(email, "@") > 1) return -4;
        // At least 1 char before @
        else if (email.indexOf("@") === 0) return -5;
        // at least 2 char between '@' and '.'
        else if (email.indexOf(".", email.indexOf("@")) - email.indexOf("@") <= 2) return -6;
        else return true;
    }

    if (email === "") {
        showErrorStyles(emailContainer, emailInputBox);
        emailMessage.innerHTML = "Hãy điền email";
    }
    else if (check() === -1) {
        showErrorStyles(emailContainer, emailInputBox);
        emailMessage.innerHTML = `Email phải chứa '@' và '.'`;
    }
    else if (check() === -2) {
        showErrorStyles(emailContainer, emailInputBox);
        emailMessage.innerHTML = `Email phải chứa '@'`;
    }
    else if (check() === -3) {
        showErrorStyles(emailContainer, emailInputBox);
        emailMessage.innerHTML = `Email phải chứa '.'`;
    }
    else if (check() === -4) {
        showErrorStyles(emailContainer, emailInputBox);
        emailMessage.innerHTML = `Email không được có nhiều hơn 1 '@'`;
    }
    else if (check() === -5) {
        showErrorStyles(emailContainer, emailInputBox);
        emailMessage.innerHTML = `Email phải có ít nhất 1 kí tự trước '@'`;
    }
    else if (check() === -6) {
        showErrorStyles(emailContainer, emailInputBox);
        emailMessage.innerHTML = `Phải có ít nhất 2 kí tự giữa '@' và '.'`;
    }
    else {
        removeErrorStyles(emailContainer, emailInputBox);
        emailMessage.innerHTML = "";
    }
}

const passwordValidate = () => {
    const passwordContainer = document.querySelector(".sign-up-password");
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

const repasswordValidate = () => {
    const repasswordContainer = document.querySelector(".sign-up-repassword");
    const repasswordInputBox = document.querySelector(".input-repassword");
    const repasswordMessage = document.querySelector(".repassword-message");
    const repassword = repasswordInputBox.value;
    const password = document.querySelector(".input-password").value;

    if (repassword === "") {
        showErrorStyles(repasswordContainer, repasswordInputBox);
        repasswordMessage.innerHTML = "Hãy xác nhận mật khẩu";
    }
    else if (repassword !== password) {
        showErrorStyles(repasswordContainer, repasswordInputBox);
        repasswordMessage.innerHTML = "Mật khẩu xác nhận không chính xác";
    }
    else {
        removeErrorStyles(repasswordContainer, repasswordInputBox);
        repasswordMessage.innerHTML = "";
    }
}

const showPassword = showPasswordButton => {
    const passwordInputBox = document.querySelector(".input-password");
    const repasswordInputBox = document.querySelector(".input-repassword");

    if (passwordInputBox.getAttribute("type") == "password") {
        passwordInputBox.setAttribute("type", "text");
        repasswordInputBox.setAttribute("type", "text");
        showPasswordButton.innerHTML = "Ẩn password";
    }
    else {
        passwordInputBox.setAttribute("type", "password");
        repasswordInputBox.setAttribute("type", "password");
        showPasswordButton.innerHTML = "Hiển thị password";
    }
}

const addEvent = (() => {
    const inputBoxes = document.querySelectorAll("[class*='input-']");
    const showPasswordButton = document.getElementById("show-psw-btn");
    const submitButton = document.querySelector(".submit-button");

    inputBoxes[0].addEventListener("blur", () => {
        fullnameValidate();
    });
    inputBoxes[1].addEventListener("blur", () => {
        usernameValidate();
    });
    inputBoxes[2].addEventListener("blur", () => {
        emailValidate();
    });
    inputBoxes[3].addEventListener("blur", () => {
        passwordValidate();
    });
    inputBoxes[4].addEventListener("blur", () => {
        repasswordValidate();
    });

    showPasswordButton.addEventListener("click", () => {
        showPassword(showPasswordButton);
    });

    submitButton.addEventListener("click", e => {
        fullnameValidate();
        usernameValidate();
        emailValidate();
        passwordValidate();
        repasswordValidate();
        const errorMessage = document.querySelector("input.error");
        if (errorMessage) {
            e.preventDefault();
        }
    });
})();