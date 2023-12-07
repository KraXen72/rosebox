const chokidar = require('chokidar');
const fs = require('fs');
const path = require('path');
const colors = require('colors')

const dist = __dirname.slice(0, __dirname.length - 7) + "dist"
const pathToOrig = `${dist}/main.css`
const MODE = "quickcss" // quickcss || settingsjson || userstyle

const pathToQuickCSSFile = `C:\\Users\\Nex\\AppData\\Roaming\\Vencord\\settings\\quickCss.css`
const pathToSettingsJSON = `C:\\Users\\Nex\\AppData\\Roaming\\Discord\\settings.json`
const pathToUserStyle = path.resolve(__dirname, "..", "dist", "roseboxUserStyle.user.css")

const userStyleHeader = [
	'/* ==UserStyle==',
	'@name           rosebox discord userstyle',
	'@namespace      https://github.com/KraXen72/rosebox',
	'@version        3.0.0',
	'@description    the rosebox discord theme as a userstyle',
	'@author         KraXen72 and contributors',
	'==/UserStyle== */',
]

const WAIT_MS = 500
console.log(`${getTimestamp()}watching main.css`.cyan)

// One-liner for current directory
chokidar.watch(pathToOrig, { ignorePermissionErrors: true }).on('all', (event, eventPath) => {
	function fileWriteCallback() {
		
		let contents = fs.readFileSync(pathToOrig, 'utf8')
		switch (MODE) {
			case "settingsjson": {
				let settingsJSON = JSON.parse(fs.readFileSync(pathToSettingsJSON))
				settingsJSON.openasar.css = contents.replaceAll('"', "\"")
				fs.writeFileSync(pathToSettingsJSON, JSON.stringify(settingsJSON))
			} break;
			case "userstyle": {
				const outputCSS = [ ...userStyleHeader, '', '@-moz-document domain("discord.com") {', contents, '}' ].join("\n")
				fs.writeFileSync(pathToUserStyle, outputCSS)
			} break;
			case "quickcss":
			default: {
				fs.writeFileSync(pathToQuickCSSFile, contents)
			} break;
		}
		console.log(`${getTimestamp()}updated compiled.user.css`.green, `mode: ${MODE}`.cyan)
	}
	//console.log(event, path);
	if (event === "change") {
		console.clear();
		console.log(`${getTimestamp()}changes detected in main.css`.yellow)
		
		setTimeout(fileWriteCallback, WAIT_MS)
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