let hideWaifu = localStorage.getItem("hideWaifu");
const waifuToggle = document.querySelector("#toggle");

const hideWaifuFunc = () => {
    const leftimage = document.getElementById("waifuimg");
    leftimage.classList.add("leftimghidden");
    const containerr = document.getElementById("maincontainer");
    containerr.classList.add("resizecontainer");
    
    localStorage.setItem("hideWaifu", "enabled");
};

const showWaifuFunc = () => {
    const leftimage = document.getElementById("waifuimg");
    leftimage.classList.remove("leftimghidden");
    const containerr = document.getElementById("maincontainer");
    containerr.classList.remove("resizecontainer");
    
    localStorage.setItem("hideWaifu", null);
};

if (hideWaifu === "enabled") {
    hideWaifuFunc();
};

const outercontainer = document.getElementById("outercontainer");
outercontainer.classList.add("showcontainer");

waifuToggle.addEventListener("click", () => {
    hideWaifu = localStorage.getItem('hideWaifu');
    if (hideWaifu !== "enabled") {
        hideWaifuFunc();
    } else {
        showWaifuFunc();
    }
});