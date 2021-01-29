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

const parentLeft = document.getElementById("wrapper-left")
const parentRight = document.getElementById("wrapper-right")

function dragSetup() {
    console.log("setting up drag&drop")
    const draggables = document.querySelectorAll('.dragabble-link')
    const containers = document.querySelectorAll('.drag-container')

    draggables.forEach(link => {
        link.addEventListener('dragstart', () => {
            link.classList.add("dragging")
            link.style.userSelect = "none"
        })

        link.addEventListener('dragend', () => {
            link.classList.remove("dragging")
            link.style.userSelect = "none"
        })
    })

    containers.forEach(container => {
        container.addEventListener('dragover', e => {
            e.preventDefault()
            const afterElement = getAfterElement(container, e.clientY)
            const current = document.querySelector('.dragging')
            
            if (afterElement == null) {
                container.appendChild(current)
            } else {
                container.insertBefore(current, afterElement)
            }
        })
    })

    function getAfterElement(c, y) {
        const dragabbleElements = [...c.querySelectorAll(".dragabble-link:not(.dragging)")]

        return dragabbleElements.reduce((closest, child) => {
            const box = child.getBoundingClientRect()
            const offset = y - box.top - box.height / 2
            if (offset < 0 && offset > closest.offset) {
                return { offset: offset, element: child}
            } else {
                return closest
            }
            
        }, {offset: Number.NEGATIVE_INFINITY}).element
    }
}

function generateLinks(mode, config, leftright, i) {
    let li = document.createElement("li");

        if (mode == "config") {
            li.draggable = "true"
            li.classList.add("dragabble-link")
            li.style.userSelect = "none";
        }

        let a = document.createElement("a")
        a.href = config[`links-${leftright}`][i].url
        a.id = `link-${i+1}`
        a.innerText = config[`links-${leftright}`][i].name
        a.style.cursor = "pointer"

        let span = document.createElement("span");
        span.classList.add("accent")
        span.innerHTML = mode == "normal" ? "~" : "&times;"
        span.style.cursor = "pointer"
        if (mode == "config") {
            a.removeAttribute('href');
            a.style.cursor = "grab"
            span.addEventListener("click", () => {if (window.confirm(`delete '${a.innerText}' ?`)) {li.remove()}})
        }
        if (mode == "config") {
            li.prepend(span)
            li.appendChild(a)
            if (leftright == "left") {
                parentLeft.appendChild(li)
            } else {
                parentRight.appendChild(li)
            }
            
        } else {
            a.prepend(span)
            li.appendChild(a)
            if (leftright == "left") {
                parentLeft.appendChild(li)
            } else {
                parentRight.appendChild(li)
            }
        }
}


function configLoad(mode, customjson) {
    
    parentLeft.innerHTML = ""
    parentRight.innerHTML = ""

    if (typeof customjson !== "undefined") {
        config = JSON.parse(customjson)
        parentRight.innerHTML = ""
        parentLeft.innerHTML = ""
    }

    console.log(config)

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
        generateLinks(mode, config, "left", i)
    }

    for (let i = 0; i < Object.keys(config["links-right"]).length; i++) {
        generateLinks(mode, config, "right", i)
    }

    if (mode == "config") {
        dragSetup()
    }

}

function showbody() {
    document.querySelector('.outercontainer').classList.add("showcontainer");
}
