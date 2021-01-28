let hideWaifu = localStorage.getItem("hideWaifu");
const waifuToggle = document.querySelector("#toggle");

let showSettings = false;
const settingsToggle = document.querySelector("#settings");

let localSettings = localStorage.getItem("jsonConfig")
if (sessionStorage.getItem('savefromeditor') !== null) {
    localSettings = sessionStorage.getItem('savefromeditor')
    localStorage.setItem("jsonConfig", localSettings)
    sessionStorage.removeItem('savefromeditor')
    window.close()
}


if (localSettings !== null) {
    configLoad("normal", localSettings)
    console.log("config loaded.")
}if (localStorage.getItem("hidebuttons") == "true") {
    let toggle = document.getElementById("toggle")
    let settings = document.getElementById("settings")

    toggle.classList.add('incognito')
    settings.classList.add('incognito')
}

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

//settings
settingsToggle.addEventListener("click", () => {
    if (showSettings == false) {
        showSettings = true

        let wrapper = document.createElement('div')
        wrapper.id = "settings-wrapper"
        wrapper.innerText = "settings"
        wrapper.style.padding = "10px"

        wrapper.innerHTML = `
        <span>
            <input type="text" class="rb-input jsoninp" id="importjson" placeholder="import json" autocomplete="off">
            <button id="json-import" class="rb-button">import and save to localStorage</button>
            <input type="text" class="rb-input jsoninp" id="exportjson" placeholder="export json" autocomplete="off">
            <button id="json-export" class="rb-button">export</button><br>
            make settings and toggle buttons only appear on hover: (refresh to take effect) <input type="checkbox" id="checkbox"><br><br>
            <button onclick="gotoconfig()" class="rb-button">CONFIGURE LINKS - reorder, delete or add new links</button>
        </span>
        <span>
        `

        document.body.appendChild(wrapper)

        if (localStorage.getItem("hidebuttons") == "true") {
            document.getElementById("checkbox").checked = true
        }

        var importjsonbtn = document.getElementById('json-import').addEventListener("click", () => {
            var jsonn = document.getElementById('importjson').value
            if (jsonn != "") {
                configLoad("normal", jsonn)
                localStorage.setItem("jsonConfig", jsonn)
                console.log("json imported.")
            } else {alert(`please paste the json you want to import into the 'import json' field.`)}
        })

        var exportjsonbtn = document.getElementById('json-export').addEventListener("click", () => {
            document.getElementById("exportjson").value = JSON.stringify(exportjsonree())
        })

        var checkbox = document.getElementById("checkbox").addEventListener("click", () => {
            if (event.currentTarget.checked == true) {
                localStorage.setItem("hidebuttons", true)
                console.log("hid buttons")
            } else {
                localStorage.setItem("hidebuttons", false)
                console.log("shown buttons")
            }
        })
        sessionStorage.setItem('tempjson', JSON.stringify(exportjsonree()))
    } else {
        document.getElementById("settings-wrapper").remove()
        showSettings = false
    }
})

function gotoconfig() {
    var jsonn = sessionStorage.getItem('tempjson')
    window.open("config.html")
}

function exportjsonree() {
    var field = document.getElementById('exportjson')
    var config = {}

    const leftLinks = [...document.getElementById('wrapper-left').children]
    const rightLinks = [...document.getElementById('wrapper-right').children]
    const imgPath = document.querySelector('img').getAttribute('src')
    const greeting = document.querySelector('h1').innerText

    if (greeting != "" || imgPath != "") {
        config.config = {
            "greeting": greeting.slice(0,greeting.length-2), 
            "img": imgPath
        }
        if (greeting == ""){delete config.config.greeting}
        if (imgPath == ""){delete config.config.img}
    }
    
    config["links-right"] = []
    config["links-left"] = []

    leftLinks.forEach(link => {
        config["links-left"].push({
            name: link.innerText.slice(1),
            url: link.querySelector('a').href
        })
    })
    rightLinks.forEach(link => {
        config["links-right"].push({
            name: link.innerText.slice(1),
            url: link.querySelector('a').href
        })
    })

    return config
}

