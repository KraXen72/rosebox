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


function configLoad(mode, customjson) {
    const parentLeft = document.getElementById("wrapper-left")
    const parentRight = document.getElementById("wrapper-right")

    if (typeof customjson !== "undefined") {
        config = JSON.parse(customjson)
        parentRight.innerHTML = ""
        parentLeft.innerHTML = ""
    }

    console.log(config)

    if ('config' in config) {
        if ('greeting' in config["config"]) {
            if (mode == "normal") {
                document.querySelector('h1').innerHTML = config.config.greeting + ` <span class="accent">~</span>`
            } else if (mode == "config") {
                document.getElementById('greeting').value = config.config.greeting
            } 
        }
        if ('img' in config["config"]) {
            if (mode == "normal") {
                document.querySelector('img').src = config.config.img
            } else if (mode == "config") {
                document.getElementById('img-path').value = config.config.img
            }
        }
    }

    for (let i = 0; i < Object.keys(config["links-left"]).length; i++) {
        let li = document.createElement("li");

        if (mode == "config") {
            li.draggable = "true"
            li.classList.add("dragabble-link")
        }

        let a = document.createElement("a")
        a.href = config["links-left"][i].url
        a.id = `link-${i+1}`
        a.innerText = config["links-left"][i].name
        a.style.cursor = "pointer"

        let span = document.createElement("span");
        span.classList.add("accent")
        span.innerHTML = mode == "normal" ? "~" : "x"
        span.style.cursor = "pointer"
        if (mode == "config") {
            //a.removeAttribute('href')
            span.addEventListener("click", () => {if (window.confirm(`delete '${a.innerText}' ?`)) {li.remove()}})
        }

        if (mode == "config") {
            li.prepend(span)
            li.appendChild(a)
            parentLeft.appendChild(li)
        } else {
            a.prepend(span)
            li.appendChild(a)
            parentLeft.appendChild(li)
        }
    }

    for (let i = 0; i < Object.keys(config["links-right"]).length; i++) {
        let li = document.createElement("li");
        if (mode == "config") {
            li.draggable = "true"
            li.classList.add("dragabble-link")
        }
            

        let a = document.createElement("a")
        a.href = config["links-right"][i].url
        a.id = `link-${i+1}`
        a.innerText = config["links-right"][i].name
        a.style.cursor = "pointer"
        

        let span = document.createElement("span");
        span.classList.add("accent")
        span.innerHTML = mode == "normal" ? "~" : "x"
        span.style.cursor = "pointer"
        if (mode == "config") {
            //a.removeAttribute('href')
            span.addEventListener("click", () => {if (window.confirm(`delete '${a.innerText}' ?`)) {li.remove()}})
        }

        if (mode == "config") {
            li.prepend(span)
            li.appendChild(a)
            parentRight.appendChild(li)
        } else {
            a.prepend(span)
            li.appendChild(a)
            parentRight.appendChild(li)
        }
        
    }
}
