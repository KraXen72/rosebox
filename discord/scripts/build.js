const fs = require('fs')
const colors = require('colors')

const pathToOrig = __dirname.slice(0, __dirname.length - 7) + "dist\\main.css"
const outputDir = `C:\\Users\\Nex\\AppData\\Roaming\\Discord\\settings.json\\rosebox.theme.css`
const importLink = `@import url('https://kraxen72.github.io/rosebox/discord/dist/main.css');`

let contents = JSON.parse(fs.readFileSync(pathToOrig, 'utf8'))
contents.openasar.css = importLink
fs.writeFileSync(outputDir, JSON.stringify(contents))

console.log(`sucessfully set openasar's css to '${importLink}'`.green)