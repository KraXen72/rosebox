const fs = require('fs')
const path = require('path')
// const sass = require('sass');

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
		// Write the fetched SCSS content to _mappings.scss with the banner
		const scssContent = banner + text;
		fs.writeFileSync(path.resolve(__dirname, '..', 'lib', '_mappings.scss'), scssContent);
		console.log("written new class mappings");

		// Extract selectors directly from the SCSS content
		// const mappingsSelectors = extractSelectorsFromScss(scssContent);
		// return mappingsSelectors;
	})
// 	.then(mappingsSelectors => {
// 		// Read and parse the _rbMappings.scss file to extract selectors
// 		const rbMappingsPath = path.resolve(__dirname, '..', 'lib', '_rbMappings.scss');
// 		const rbMappingsContent = fs.readFileSync(rbMappingsPath, 'utf-8');

// 		// Extract selectors directly from the SCSS content of _rbMappings.scss
// 		const rbSelectors = extractSelectorsFromScss(rbMappingsContent);

// 		// Find and print selectors that are in both mappingsSelectors and rbSelectors
// 		const commonSelectors = mappingsSelectors.filter(selector => rbSelectors.includes(selector));
// 		console.log("Common Selectors:", commonSelectors);

// 	})
// 	.catch(err => console.error('Error fetching or processing SCSS:', err));

// /**
//  * Function to extract selectors from SCSS content
//  * @param {string} scssContent - SCSS content
//  * @returns {Array} - Array of selectors
//  */
// function extractSelectorsFromScss(scssContent) {
// 	const lines = scssContent.split('\n');
// 	const selectors = [];

// 	lines.forEach(line => {
// 		line = line.trim();
// 		if (line.startsWith('.') || line.startsWith('%')) {
// 			const selector = line.split(' ')[0].replace('{', '').trim();
// 			if (!selectors.includes(selector)) {
// 				selectors.push(selector);
// 			}
// 		}
// 	});

// 	return selectors;
// }