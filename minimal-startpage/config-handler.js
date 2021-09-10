//this file will be used to handle everything related to configuring the startpage, all setting screens etc

const confHandler = {}

//TODO rewrite in createelement manner
let settingsHTML = `
<div class="extrasettings">
    <div id="vanilla-settings">${/*these are the normal settings that show initailly*/""}
        <input type="text" class="rb-input jsoninp" id="importjson" placeholder="import json" autocomplete="off" />
        <button id="json-import" class="rb-button">import and save to localStorage</button>
        <input type="text" class="rb-input jsoninp" id="exportjson" placeholder="export json" autocomplete="off" />
        <button id="json-export" class="rb-button">export</button><br />
        <br />
        make settings and toggle buttons only appear on hover: (refresh to take effect) <input type="checkbox" id="checkbox" /><br />
        <br />
    </div>
    <span>
        ${/*CONFIGURE, CANCEL and X buttons*/""}
        <button class="rb-button" id="gotoconfig">CONFIGURE LINKS</button>
        <button class="rb-button" id="cancel">CANCEL</button>
        <button class="rb-button" id="close-settings"><strong>&times;</strong></button>
    </span>
    ${/*Config settigns*/""}
    <div id="config-controls">
        <br />
        <p>
            drag & drop to reorder, click <span class="accent" style="padding: 0px;">x</span> to delete. <br />
            I's recommended for a column to have <span class="accent" style="padding: 0px;">8</span> links for it to look good.
        </p>
        add a link:<input type="text" class="rb-input" id="name" placeholder="name" autocomplete="off" /><input type="text" class="rb-input" id="url" placeholder="url" autocomplete="off" />
        <button id="link-add" class="rb-button">add</button><br />
        greeting text:<input type="text" class="rb-input" id="greeting-inp" placeholder="heya" autocomplete="off" /><br />
        custom left image:<input type="text" class="rb-input" id="img-path" placeholder="path or link to image" autocomplete="off" />
    </div>
</div>

`

/**
 * generates json from curretnly configured stuffs
 * @param {String} exportmode 'normal' or 'config'
 */
confHandler.exportjsonree = (exportmode) => {
    var config = {}

    const leftLinks = [...document.getElementById('wrapper-left').children]
    const rightLinks = [...document.getElementById('wrapper-right').children]

    var imgPath = ""
    var greeting = ""

    if (exportmode == "config") { //when saving from config
        imgPath = document.getElementById("img-path").value
        greeting = document.getElementById("greeting-inp").value
    } else { //when exporting from normal
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

/**
 * creates the inital settings element
 */
 confHandler.createSettingsElem = () => {

    //create the inital element
    let wrapper = document.createElement('div')
    wrapper.id = "settings-wrapper"
    wrapper.innerText = "settings"
    //wrapper.style.padding = "10px"

    wrapper.innerHTML = settingsHTML

    //document.body.prependChild(wrapper)
    document.body.appendChild(wrapper)

    //check the checkbox if localstorage has it checked
    if (localStorage.getItem("hidebuttons") == "true") {
        document.getElementById("checkbox").checked = true
    }

    //add all click eventlisteners

    //vanilla settings
    //hide buttons checkbox
    document.getElementById("checkbox").addEventListener("click", () => {
        if (event.currentTarget.checked == true) {
            localStorage.setItem("hidebuttons", true)
            console.log("hid buttons")
        } else {
            localStorage.setItem("hidebuttons", false)
            console.log("shown buttons")
        }
    })

    
    //import json
    document.getElementById('json-import').addEventListener("click", () => {
        var jsonn = document.getElementById('importjson').value
        
        if (jsonn != "") {
            //validate if its actual json because no one would every put something else in a json field  riiight?
            try {
                let valid = JSON.parse(jsonn)
                dataHandler.configLoad("normal", jsonn)
                localStorage.setItem("jsonConfig", jsonn)
                
                console.log("json imported.")
            } catch (e) {
                alert("this is not json silly :)")
            }
        } else {alert(`please paste the json you want to import into the 'import json' field.`)}
    })

    //export json
    document.getElementById('json-export').addEventListener("click", () => {
        document.getElementById("exportjson").value = JSON.stringify(confHandler.exportjsonree("normal"))
    })

    //close settings
    document.getElementById('close-settings').addEventListener("click", () => {
        document.querySelector('#settings').click()
    })
    
    //config settings
    //add link
    document.getElementById("link-add").addEventListener("click", () => {
        const name = document.getElementById("name").value
        const urll = document.getElementById("url").value

        const parent = document.getElementById("wrapper-left")

        if (name == "" || urll == "") {
            alert("please enter a name and an url for the link.")
            return
        }

        //manufacture the link
        let li = document.createElement("li");
        li.draggable = "true"
        li.classList.add("dragabble-link")

        let a = document.createElement("a")
        a.href = urll
        a.innerText = name
        a.style.cursor = "pointer"

        let span = document.createElement("span");
        span.classList.add("accent")
        span.innerHTML = "&times;"
        span.style.cursor = "pointer"
        
        a.removeAttribute('href')
        span.addEventListener("click", () => {if (window.confirm(`delete '${a.innerText}' ?`)) {li.remove()}})

        li.prepend(span)
        li.appendChild(a)
        parent.appendChild(li)

        a.href = urll
    
        document.getElementById("name").value = ""
        document.getElementById("url").value = ""

        spHandler.dragSetup() //re-setup dragging to also make the new link draggable
    })

    //save
    document.getElementById('gotoconfig').addEventListener("click", () => {
        confHandler.gotoconfig('save')
    })

    //cancel
    document.getElementById('cancel').addEventListener("click", () => {
        confHandler.gotoconfig('cancel')
    })

    //greeting input
    document.getElementById('greeting-inp').addEventListener("input", () => {
        confHandler.updategreeting(document.getElementById('greeting-inp'))
    })

    //img-path input
    document.getElementById('img-path').addEventListener("input", () => {
        confHandler.updateimg(document.getElementById('img-path'))
    })
}

/**
 * update the greeting
 */
confHandler.updategreeting = (el) => {
    document.getElementById("greeting").innerText = el.value
}

/**
 * update the image
 */
confHandler.updateimg = (el) => {
    document.querySelector('img').src = el.value
}


/**
 * go to / exit the config screen
 * @param {String} mode 'save' or 'cancel'. 
 */
confHandler.gotoconfig = (mode) => {
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

        dataHandler.configLoad("config")

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
            let bruh = JSON.stringify(confHandler.exportjsonree("config"))
            dataHandler.configLoad("normal", bruh)
            localStorage.setItem("jsonConfig", bruh)
        } else {
            dataHandler.configLoad("normal")
        }
    }
}

console.log("init config-handler")