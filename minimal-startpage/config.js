function dragSetup() {
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

//link adding

document.getElementById("link-add").addEventListener("click", () => {
    const name = document.getElementById("name").value
    const urll = document.getElementById("url").value

    const parent = document.getElementById("wrapper-left")

    if (name == "" || urll == "") {
        alert("please enter a name and an url for the link.")
        return
    }
    console.log(urll)

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
    span.addEventListener("click", () => {if (window.confirm(`delete '${a.innerText.slice(1)}' ?`)) {li.remove()}})

    li.prepend(span)
    li.appendChild(a)
    parent.appendChild(li)

    a.href = urll
   
    document.getElementById("name").value = ""
    document.getElementById("url").value = ""

    dragSetup()
})

document.getElementById("json-export").addEventListener("click", () => {
    
    document.getElementById("exportjson").value = JSON.stringify(exportjsonconfig())
})

document.getElementById("json-import").addEventListener("click", () => {
    var config = {}
    const imp = document.getElementById("importjson")

    if (imp.value != "") {
        const parentLeft = document.getElementById("wrapper-left")
        const parentRight = document.getElementById("wrapper-right")

        parentLeft.innerHTML = ""
        parentRight.innerHTML = ""

        config = imp.value

        configLoad("config", config) //load the new json
    } else {alert("please paste the json you want to import in the 'import json' field.")}
})

function exportjsonconfig() {
    var config = {}

    const leftLinks = [...document.getElementById('wrapper-left').children]
    const rightLinks = [...document.getElementById('wrapper-right').children]
    const imgPath = document.getElementById("img-path").value
    const greeting = document.getElementById("greeting").value

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

    console.log(config)
    return config
}

function saveandreturn() {
    sessionStorage.setItem('savefromeditor', JSON.stringify(exportjsonconfig()))
    window.location.href = "index.html"
}

if (sessionStorage.getItem('tempjson') !== null) {
    configLoad("config", sessionStorage.getItem('tempjson'))
    sessionStorage.removeItem('tempjson')
}
dragSetup()