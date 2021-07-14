// this file is used to handle all localStorage logic, data saving and loading, all saving and loading utility functions

//the main object which has all the data in it
var config = {
    "config": {
        "greeting": "heya",
        "img": "img/yahallo.png"
        
    },
    "links-left": [
        {
            "name": "gmail",
            "url": "https://mail.google.com/mail/u/0/#inbox"
        },
        {
            "name": "outlook",
            "url": "https://login.microsoftonline.com/common/oauth2/authorize?client_id=00000002-0000-0ff1-ce00-000000000000&redirect_uri=https%3a%2f%2foutlook.office365.com%2fowa%2f&resource=00000002-0000-0ff1-ce00-000000000000&response_mode=form_post&response_type=code+id_token&scope=openid&msafed=0&client-request-id=78bf890f-0b5c-4cf4-a80a-a4400ccc6641&protectedtoken=true&domain_hint=gamca.sk&nonce=637094247029805070.17ea6557-27d5-4316-a030-99ab8b69723a&state=Dcs7EoAgDEVR0NqlRMInPLKcoI6F41hYuH0pzu2ud87NwzR4HnGoGawlFXDSxsLgNeKwKgJK2IVKjpWMM5Oq9darImXz413C81k47d5sfa8f"
        },
        {
            "name": "r/unixpron",
            "url": "https://www.reddit.com/r/unixporn/"
        },
        {
            "name": "r/mk",
            "url": "https://www.reddit.com/r/MechanicalKeyboards/"
        },
        {
            "name": "monkeytype",
            "url": "https://monkeytype.com/"
        },
        {
            "name": "rosebox",
            "url": "https://github.com/KraXen72/rosebox"
        },
        {
            "name": "krunker market",
            "url": "https://www.krunker.io/social.html"
        },
        {
            "name": "yeehow item list",
            "url": "https://yee.how/item-list/"
        }

    ],
    "links-right": [
        {
            "name": "github",
            "url": "https://github.com/"
        },
        {
            "name": "vivaldi mod forum",
            "url": "https://forum.vivaldi.net/category/52/modifications"
        },
        {
            "name": "trello",
            "url": "https://trello.com/kraxen7/boards"
        },
        {
            "name": "pcmskin3d",
            "url": "https://www.planetminecraft.com/pmcskin3d/"
        },
        {
            "name": "keybr",
            "url": "https://www.keybr.com/"
        },
        {
            "name": "planning center",
            "url": "https://services.planningcenteronline.com/dashboard/0"
        },
        {
            "name": "wallpaper collection",
            "url": "https://mega.nz/folder/PpohCIpT#tII4Q60AFpgfnEYFywwlow"
        },
        {
            "name": "catus airsoft",
            "url": "https://catus.sk"
        }
    ]
}

//main Handler object which will house all the methods.
const dataHandler = {}

/**
 * load the links into the startpage from localStorage or provided json
 * @param {String} mode "normal" or "config" normal loads everything normally, config loads stuff for configuring (drag n drop enabled etc)
 * @param {String} customjson json (string) to load
 */
dataHandler.configLoad = (mode, customjson) => {
    const parentLeft = window.globals.parentLeft
    const parentRight = window.globals.parentRight
    
    parentLeft.innerHTML = ""
    parentRight.innerHTML = ""

    if (typeof customjson !== "undefined") {
        config = JSON.parse(customjson)
        parentRight.innerHTML = ""
        parentLeft.innerHTML = ""
    }

    if ('config' in config) {
        if ('greeting' in config["config"]) {
                document.querySelector('#greeting').innerText = config.config.greeting
        }
        if ('img' in config["config"]) {
                document.querySelector('img').src = config.config.img
        }
    }

    let borderme = document.querySelectorAll(".borderme")
    let marginleft = document.querySelector(".w3gridclass")

    if (mode == "config") {
        borderme.forEach(e => {e.classList.add("borderme-bordered")});
        marginleft.classList.add("marginleft194")
    } else {
        borderme.forEach(e => {e.classList.remove("borderme-bordered")});
        marginleft.classList.remove("marginleft194")
    }

    for (let i = 0; i < Object.keys(config["links-left"]).length; i++) {
        spHandler.renderLink(mode, config, "left", i)
    }

    for (let i = 0; i < Object.keys(config["links-right"]).length; i++) {
        spHandler.renderLink(mode, config, "right", i)
    }

    if (mode == "config") {
        spHandler.dragSetup()
    }

    console.log("loaded config: ", config)
}
function configloadnormal() {configLoad("normal")}

console.log("init data-handler"/*, dataHandler*/)

