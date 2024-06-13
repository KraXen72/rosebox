//this file is for handling anything with setting up / displaying the startpage itself

//main Handler object which will house all the methods.
const spHandler = {
    waifu: {}
}

/**
 * render link for a specific parent. must be called separately for every link (ex. using a for loop)
 * @param {String} mode "normal" or "config", normal adds ~ before links, config adds &times; which are x buttons
 * @param {Object} config the config object to reference data from
 * @param {String} leftright "left" or "right", used to determine which side to render links for
 * @param {Number} i index of the link
 */
spHandler.renderLink = (mode, config, leftright, i) => {
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
        a.setAttribute("url", a.getAttribute("href"))
        a.removeAttribute('href');
        a.style.cursor = "grab"
        span.addEventListener("click", () => {if (window.confirm(`delete '${a.innerText}' ?`)) {li.remove()}})
    }
    if (mode == "config") {
        li.prepend(span)
        li.appendChild(a)
        if (leftright == "left") {
            window.globals.parentLeft.appendChild(li)
        } else {
            window.globals.parentRight.appendChild(li)
        }
        
    } else {
        a.prepend(span)
        li.appendChild(a)
        if (leftright == "left") {
            window.globals.parentLeft.appendChild(li)
        } else {
            window.globals.parentRight.appendChild(li)
        }
    }
}

/**
 * set up dragging behaviour. expects .draggable-link as draggables and .drag-container as their parent
 */
spHandler.dragSetup = () => {
    console.log("setting up drag&drop")
    const draggables = document.querySelectorAll('.dragabble-link')
    const containers = document.querySelectorAll('.drag-container')


    draggables.forEach(link => {
        //add dragging class when we recieve 'dragstart' event and remove the class on 'dragend' event
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
            //inserts the element in the correct position in the container after finished dragging
            const afterElement = getAfterElement(container, e.clientY)
            const current = document.querySelector('.dragging')
            
            if (afterElement == null) {
                container.appendChild(current)
            } else {
                container.insertBefore(current, afterElement)
            }
        })
    })
    
    //get the element we want to put the .dragging element after
    function getAfterElement(c, y) {
        const dragabbleElements = [...c.querySelectorAll(".dragabble-link:not(.dragging)")]

        //black magic to determine if its before or after the element, using the boundingClientRect
        //don't ask me how it works only webDevSimplified on youtube knows
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

//waifu toggling (left image toggling)
//show and hide the left image respectively
spHandler.waifu.show = () => {
    window.globals.leftimage.classList.remove("leftimghidden");
    window.globals.maincontainer.classList.remove("noimage");
    
    localStorage.setItem("hideWaifu", null);
}
spHandler.waifu.hide = () => {
    window.globals.leftimage.classList.add("leftimghidden");
    window.globals.maincontainer.classList.add("noimage");
    
    localStorage.setItem("hideWaifu", "enabled");
}

console.log("init startpage-handler"/*, spHandler*/)