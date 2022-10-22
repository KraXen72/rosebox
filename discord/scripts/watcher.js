const chokidar = require('chokidar');
const fs = require('fs');
const colors = require('colors')

const dist = __dirname.slice(0, __dirname.length - 7) + "dist"
const pathToOrig = `${dist}/main.css`
const MODE = "quickcss" // quickcss or settingsjson

const wait = 500
console.log(`${getTimestamp()}watching main.css`.cyan)

// One-liner for current directory
chokidar.watch(pathToOrig, { ignorePermissionErrors: true }).on('all', (event, path) => {
	//console.log(event, path);
	if (event === "change") {
		console.clear();
		console.log(`${getTimestamp()}changes detected in main.css`.yellow)

		if (MODE === "settingsjson") {
			setTimeout(() => { //wait 'wait' amount of ms
				const pathToSettingsJSON = `C:\\Users\\Nex\\AppData\\Roaming\\Discord\\settings.json`
				let contents = fs.readFileSync(pathToOrig, 'utf8')
				let settingsJSON = JSON.parse(fs.readFileSync(pathToSettingsJSON))
				settingsJSON.openasar.css = contents.replaceAll('"', "\"")
				fs.writeFileSync(pathToSettingsJSON, JSON.stringify(settingsJSON))
	
				console.log(`${getTimestamp()}updated compiled.user.css`.green, `mode: ${MODE}`.cyan)
			}, wait)
		} else if (MODE === "quickcss") {
			setTimeout(() => { //wait 'wait' amount of ms
				const pathToQuickCSSFile = `C:\\Users\\Nex\\AppData\\Roaming\\Vencord\\settings\\quickCss.css`

				let contents = fs.readFileSync(pathToOrig, 'utf8')
				fs.writeFileSync(pathToQuickCSSFile, contents)
	
				console.log(`${getTimestamp()}updated compiled.user.css`.green, `mode: ${MODE}`.cyan)
			}, wait)
		}
	}
}).on('error', error => console.log(`Watcher error: ${error}`));

function getTimestamp() {
	let d = new Date(Date.now())
	return (`${pad(d.getHours(), 2)}:${pad(d.getMinutes(), 2)}:${pad(d.getSeconds(), 2)} > `)
}
function pad(n, width) {
	let z = '0';
	n = n + '';
	return n.length >= width ? n : new Array(width - n.length + 1).join(z) + n;
}