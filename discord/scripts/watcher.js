const chokidar = require('chokidar');
const fs = require('fs');
const path = require('path');
const colors = require('colors')

const dist = __dirname.slice(0, __dirname.length - 7) + "dist"
const pathToOrig = `${dist}/main.css`
const MODES = ["quickcss", "userstyle"] // quickcss || settingsjson || userstyle
const packageJson = JSON.parse(fs.readFileSync('./package.json'))

// const pathToQuickCSSFile = `C:\\Users\\Nex\\AppData\\Roaming\\Vencord\\settings\\quickCss.css`
const quickCssOutPaths = [
	`/home/nex/.config/Vencord/settings/quickCss.css`,
	`/home/nex/.config/vesktop/settings/quickCss.css`
]
// const pathToSettingsJSON = `C:\\Users\\Nex\\AppData\\Roaming\\Discord\\settings.json`
const pathToSettingsJSON = `/home/nex/.config/discord/settings.json`
const pathToUserStyle = path.resolve(__dirname, "..", "dist", "roseboxUserStyle.user.css")

const userStyleHeader = [
	'/* ==UserStyle==',
	'@name           rosebox discord userstyle',
	'@namespace      https://github.com/KraXen72/rosebox',
	`@version        ${packageJson.version}`,
	'@description    the rosebox discord theme as a userstyle',
	'@author         KraXen72 and contributors',
	'==/UserStyle== */',
]

const WAIT_MS = 500
console.log(`${getTimestamp()}watching main.css`.cyan)

function fileWriteCallback() {
	let contents = fs.readFileSync(pathToOrig, 'utf8')
	if (MODES.includes('settingsjson')) {
		let settingsJSON = JSON.parse(fs.readFileSync(pathToSettingsJSON))
		settingsJSON.openasar.css = contents.replaceAll('"', "\"")
		fs.writeFileSync(pathToSettingsJSON, JSON.stringify(settingsJSON))
	}
	if (MODES.includes("userstyle")) {
		const outputCSS = [...userStyleHeader, '', '@-moz-document domain("discord.com") {', contents, '}'].join("\n")
		fs.writeFileSync(pathToUserStyle, outputCSS)
	}
	if (MODES.includes("quickcss") || MODES.length === 0) {
		for (p of quickCssOutPaths) {
			fs.writeFileSync(p, contents)
		}
	}
	console.log(`${getTimestamp()}updated compiled.user.css`.green, `modes: ${MODES.join(", ")}`.cyan)
}

// One-liner for current directory
chokidar.watch(pathToOrig, { ignorePermissionErrors: true }).on('all', (event, eventPath) => {
	//console.log(event, path);
	if (event === "change") {
		console.clear();
		console.log(`${getTimestamp()}changes detected in main.css`.yellow)

		setTimeout(fileWriteCallback, WAIT_MS)
	}
}).on('error', error => console.log(`Watcher error: ${error}`));
fileWriteCallback()

function getTimestamp() {
	let d = new Date(Date.now())
	return (`${pad(d.getHours(), 2)}:${pad(d.getMinutes(), 2)}:${pad(d.getSeconds(), 2)} > `)
}
function pad(n, width) {
	let z = '0';
	n = n + '';
	return n.length >= width ? n : new Array(width - n.length + 1).join(z) + n;
}