const fs = require('fs')
const path = require('path')

const banner = `// map placeholders to classes, so when discord changes the class names i only have to fix them in one place
// in 2023 this theme was re-written to use as little class selectors as possible, so it is easier to maintain
// credits: https://github.com/ClearVision/ClearVision-v6/blob/master/lib/selectors/selectorPlaceholders.scss
// this repo uses a script (scripts/updateSelectors.js) to fetch these mappings into lib/_mappings.scss
// unused mappings don't get included in the theme, due to the way they are written

`

process.env['NODE_TLS_REJECT_UNAUTHORIZED'] = '0';
fetch("https://raw.githubusercontent.com/ClearVision/ClearVision-v6/master/lib/selectors/selectorPlaceholders.scss")
	.then(data => data.text())
	.then(text => {
		fs.writeFileSync(path.resolve(__dirname, '..', 'lib', '_mappings.scss'), banner + text)
		console.log("written new class mappings")
	})