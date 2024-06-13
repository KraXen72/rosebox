const fs = require('fs')
const colors = require('colors')

const pathToSettingsJSON = `C:\\Users\\Nex\\AppData\\Roaming\\Discord\\settings.json`
const importLink = `@import url('https://kraxen72.github.io/rosebox/discord/dist/main.css');`

let contents = JSON.parse(fs.readFileSync(pathToSettingsJSON, 'utf8'))
contents.openasar.css = importLink
fs.writeFileSync(pathToSettingsJSON, JSON.stringify(contents))

console.log(`sucessfully set openasar's css to '${importLink}'`.green)