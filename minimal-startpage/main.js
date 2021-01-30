let hideWaifu = localStorage.getItem("hideWaifu");
const waifuToggle = document.querySelector("#toggle");

let showSettings = false;
const settingsToggle = document.querySelector("#settings");

//loading stuff
let localSettings = localStorage.getItem("jsonConfig")
if (sessionStorage.getItem('savefromeditor') !== null) {
    localSettings = sessionStorage.getItem('savefromeditor')
    localStorage.setItem("jsonConfig", localSettings)
    sessionStorage.removeItem('savefromeditor')
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
//image toggling
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
if (hideWaifu === "enabled") {hideWaifuFunc();};

const outercontainer = document.getElementById("outercontainer");

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
        <div class="extrasettings">
            <div id="vanilla-settings">
                <input type="text" class="rb-input jsoninp" id="importjson" placeholder="import json" autocomplete="off">
                <button id="json-import" class="rb-button">import and save to localStorage</button>
                <input type="text" class="rb-input jsoninp" id="exportjson" placeholder="export json" autocomplete="off">
                <button id="json-export" class="rb-button">export</button><br><br>
                make settings and toggle buttons only appear on hover: (refresh to take effect) <input type="checkbox" id="checkbox"><br><br>
            </div>
            <span><button onclick="gotoconfig('save')" class="rb-button" id="gotoconfig">CONFIGURE LINKS</button><button onclick="gotoconfig('cancel')" class="rb-button" id="cancel">CANCEL</button>  <button onclick="document.querySelector('#settings').click()" id="close-settings" class="rb-button"><strong>&times;</strong></button></span>
            <div id="config-controls"><br>
            <p>drag & drop to reorder, click <span class="accent" style="padding: 0px;">x</span> to delete. <br>
                I's recommended for a column to have <span class="accent" style="padding: 0px;">8</span> links for it to look good.</p>
                add a link:<input type="text" class="rb-input" id="name" placeholder="name" autocomplete="off"><input type="text" class="rb-input" id="url" placeholder="url" autocomplete="off"><button id="link-add" class="rb-button">add</button><br>
                greeting text:<input type="text" class="rb-input" id="greeting-inp" placeholder="heya" autocomplete="off" oninput = "updategreeting(this)"><br>
                custom left image:<input type="text" class="rb-input" id="img-path" placeholder="path or link to image" autocomplete="off" oninput = "updateimg(this)">
            </div>
        </div>
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
            document.getElementById("exportjson").value = JSON.stringify(exportjsonree("normal"))
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

        document.getElementById("link-add").addEventListener("click", () => {
            const name = document.getElementById("name").value
            const urll = document.getElementById("url").value
        
            const parent = document.getElementById("wrapper-left")
        
            if (name == "" || urll == "") {
                alert("please enter a name and an url for the link.")
                return
            }
        
            let li = document.createElement("li");
            li.draggable = "true"
            li.classList.add("dragabble-link")
        
            let a = document.createElement("a")
            a.href = urll
            a.innerText = name
            a.style.cursor = "pointer"
        
            let span = document.createElement("span");
            span.classList.add("accent")
            span.innerHTML = "x"
            span.style.cursor = "pointer"
            
            a.removeAttribute('href')
            span.addEventListener("click", () => {if (window.confirm(`delete '${a.innerText}' ?`)) {li.remove()}})
        
            li.prepend(span)
            li.appendChild(a)
            parent.appendChild(li)
        
            a.href = urll
           
            document.getElementById("name").value = ""
            document.getElementById("url").value = ""
        
            dragSetup()
        })
    } else {
        document.getElementById("settings-wrapper").remove()
        showSettings = false
    }
})

function updategreeting(el) {
    document.getElementById("greeting").innerText = el.value
}

function updateimg(el) {
    document.querySelector('img').src = el.value
}

function gotoconfig(mode) {
    let configbtn = document.getElementById("gotoconfig")
    let configControls = document.getElementById("config-controls")
    let vanillaSettings = document.getElementById("vanilla-settings")
    let cancel = document.getElementById("cancel")
    

    if (configbtn.innerHTML == "CONFIGURE LINKS") {
        configbtn.innerHTML = "<strong>SAVE</strong> AND RETURN TO STARTPAGE"

        //show elements
        configControls.style.display = "block"
        cancel.style.display = "block"

        //hide elements
        vanillaSettings.style.display = "none"
        document.querySelector('#close-settings').style.display = "none"

        configLoad("config")

        //if we are missing anything from config.config, fill it in by defaults
        if (!('config' in config) || typeof config.config.greeting === "undefined" || typeof config.config.img === "undefined") { 
            config.config = {};
            config.config.greeting = document.querySelector('#greeting').innerText
            config.config.img = document.querySelector('img').getAttribute("src")
        }
        //load things from config to inputs
        document.getElementById("greeting-inp").value = config.config.greeting
        document.getElementById("img-path").value = config.config.img
        
    } else {
        configbtn.innerHTML = "CONFIGURE LINKS"

        //show elements
        vanillaSettings.style.display = "block"
        document.querySelector('#close-settings').style.display = "inline-block"
        
        //hide elements
        configControls.style.display = "none"
        cancel.style.display = "none"
        
        if (mode == "save") { /*save the config into localstorage*/
            let bruh = JSON.stringify(exportjsonree("config"))
            configLoad("normal", bruh)
            localStorage.setItem("jsonConfig", bruh)
        } else {
            configLoad("normal")
        }
    }
}

function exportjsonree(exportmode) { /*doesen't work for config exporting yet tm*/
    var config = {}

    const leftLinks = [...document.getElementById('wrapper-left').children]
    const rightLinks = [...document.getElementById('wrapper-right').children]

    var imgPath = ""
    var greeting = ""

    if (exportmode == "config") {
        imgPath = document.getElementById("img-path").value
        greeting = document.getElementById("greeting-inp").value
    } else {
        imgPath = document.querySelector('img').getAttribute('src')
        greeting = document.querySelector('#greeting').innerText
    }
    
    if (greeting != "" || imgPath != "") {
        config.config = {
            "greeting": greeting, 
            "img": imgPath
        }
        if (greeting == ""){delete config.config.greeting}
        if (imgPath == ""){delete config.config.img}
    }
    
    config["links-right"] = []
    config["links-left"] = []

    leftLinks.forEach(link => {
        console.log(link)
        config["links-left"].push({
            name: link.innerText.slice(1),
            url: link.querySelector('a').getAttribute("href") != null ? link.querySelector('a').getAttribute("href") : link.querySelector('a').getAttribute("url")
        })
    })
    rightLinks.forEach(link => {
        config["links-right"].push({
            name: link.innerText.slice(1),
            url: link.querySelector('a').getAttribute("href") != null ? link.querySelector('a').getAttribute("href") : link.querySelector('a').getAttribute("url")
        })
    })

    return config
}



