let hideWaifu = localStorage.getItem("hideWaifu");
const waifuToggle = document.querySelector("#toggle");

const hideWaifuFunc = () => {
    var leftimage = document.getElementById("waifuimg");
    leftimage.classList.add("leftimghidden");
    var containerr = document.getElementById("maincontainer");
    containerr.classList.add("resizecontainer");
    
    localStorage.setItem("hideWaifu", "enabled");
};

const showWaifuFunc = () => {
    var leftimage = document.getElementById("waifuimg");
    leftimage.classList.remove("leftimghidden");
    var containerr = document.getElementById("maincontainer");
    containerr.classList.remove("resizecontainer");
    
    localStorage.setItem("hideWaifu", null);
};

if (hideWaifu === "enabled") {
    hideWaifuFunc();
};

waifuToggle.addEventListener("click", () => {
    hideWaifu = localStorage.getItem('hideWaifu');
    if (hideWaifu !== "enabled") {
        hideWaifuFunc();
    } else {
        showWaifuFunc();
    }
});