const chokidar = require('chokidar');
const fs = require('fs');
const colors = require('colors')

const dist = __dirname.slice(0, __dirname.length - 7) + "dist"
const pathToOrig = `${dist}/main.css`
const pathToUserCss = `C:\\Users\\Nex\\AppData\\Roaming\\BetterDiscord\\themes\\rosebox.theme.css`
const header = 
`/**
* @name rosebox
* @version 2.0
* @description rosebox theme for discord
* @author KraXen72
* @authorId 379304073515499530
* @source https://github.com/KraXen72/rosebox/tree/master/discord
*/
`
const wait = 500
console.log(`${getTimestamp()}watching main.css`.cyan)

// One-liner for current directory
chokidar.watch(pathToOrig, {ignorePermissionErrors: true}).on('all', (event, path) => {
  //console.log(event, path);
  if (event === "change") {
    console.clear();
    console.log(`${getTimestamp()}changes detected in main.css`.yellow)

    setTimeout(() => { //wait 'wait' amount of ms
      let contents = fs.readFileSync(pathToOrig, 'utf8')
      let newcontents = header + contents //+ "}"
      fs.writeFileSync(pathToUserCss, newcontents)
    
      console.log(`${getTimestamp()}updated compiled.user.css`.green)
    }, wait)

  }
}).on('error', error => log(`Watcher error: ${error}`));

function getTimestamp() {
  let d = new Date(Date.now())
  return (`${pad(d.getHours(), 2)}:${pad(d.getMinutes(), 2)}:${pad(d.getSeconds(), 2)} > `)
}
function pad(n, width) {
  z = '0';
  n = n + '';
  return n.length >= width ? n : new Array(width - n.length + 1).join(z) + n;
}