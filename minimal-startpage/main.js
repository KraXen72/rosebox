//globals
window.globals = {}
window.globals.parentLeft = {}
window.globals.parentRight = {}
window.globals.leftimage = {}
window.globals.maincontainer = {}

//localstorage
let hideWaifu = localStorage.getItem("hideWaifu"); //saved value if image is hidden or not
let localSettings = localStorage.getItem("jsonConfig") //current links and settings saved in localstorage

let showSettings = false;

document.addEventListener('DOMContentLoaded', () => {
    window.globals.parentLeft = document.getElementById("wrapper-left")
    window.globals.parentRight = document.getElementById("wrapper-right")
    window.globals.leftimage = document.getElementById("waifuimg");
    window.globals.maincontainer = document.getElementById("maincontainer");

    document.querySelector('img').onload = showbody
    document.querySelector('img').onerror = showbody

    //if we checked "make settings and toggle buttons only appear on hover", then add .incognito to them
    if (localStorage.getItem("hidebuttons") == "true") {
        document.getElementById("toggle").classList.add('incognito')
        document.getElementById("settings").classList.add('incognito')
    }

    //load config
    if (localSettings !== null) { //if we already have something saved, load it
        dataHandler.configLoad("normal", localSettings)
    } else {
        dataHandler.configLoad("normal", JSON.stringify(config))
    }

    //image toggling
    if (hideWaifu === "enabled") {spHandler.waifu.hide()}; //hide image if set to hide
    document.querySelector("#toggle").onclick = () => { //add eventlistener to toggle
        hideWaifu = localStorage.getItem('hideWaifu');
        if (hideWaifu !== "enabled") {
            spHandler.waifu.hide()
        } else {
            spHandler.waifu.show()
        }
    }

    //settings
    document.getElementById('settings').addEventListener("click", () => {
        if (showSettings == false) {
            showSettings = true
            confHandler.createSettingsElem()
        } else {
            document.getElementById("settings-wrapper").remove()
            showSettings = false
        }
    })
})

function showbody() {
    document.getElementById('outercontainer').classList.add("showcontainer"); //show the container on image load
}

console.log("---------- loaded main ----------")