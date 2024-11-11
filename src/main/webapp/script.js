document.addEventListener("DOMContentLoaded", function () {
    const passwordInput = document.getElementById("password");
    const toggleButton = document.createElement("i");

    toggleButton.classList.add("fa-solid", "fa-eye-slash"); // Initial icon for hidden password
    toggleButton.style.cursor = "pointer";
    toggleButton.style.position = "absolute";
    toggleButton.style.right = "10px";
    toggleButton.style.top = "65%";
    toggleButton.style.transform = "translateY(-50%)";
    toggleButton.style.fontSize = "15px";

    const passwordContainer = passwordInput.parentElement;
    passwordContainer.style.position = "relative";
    passwordContainer.appendChild(toggleButton);

    toggleButton.addEventListener("click", function () {
        if (passwordInput.type === "password") {
            passwordInput.type = "text";
            toggleButton.classList.remove("fa-eye-slash");
            toggleButton.classList.add("fa-eye");
        } else {
            passwordInput.type = "password";
            toggleButton.classList.remove("fa-eye");
            toggleButton.classList.add("fa-eye-slash");
        }
    });
});
