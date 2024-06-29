const fs = require('fs')
const path = require('path')

const banner = `// map placeholders to classes, so when discord changes the class names i only have to fix them in one place
// in 2023 this theme was re-written to use as little class selectors as possible, so it is easier to maintain
// credits: https://github.com/ClearVision/ClearVision-v6/blob/master/lib/selectors/selectorPlaceholders.scss
// this repo uses a script (scripts/updateSelectors.js) to fetch these mappings into lib/_mappings.scss
// unused mappings don't get included in the theme, due to the way they are written

`

// process.env['NODE_TLS_REJECT_UNAUTHORIZED'] = '0';

fetch("https://raw.githubusercontent.com/ClearVision/ClearVision-v6/master/lib/selectors/selectorPlaceholders.scss")
	.then(data => data.text())
	.then(text => {
		const scssContent = banner + text;
		fs.writeFileSync(path.resolve(__dirname, '..', 'lib', '_mappings.scss'), scssContent);
		console.log("written new class mappings");

		return scssContent;
	})
	.then(findDuplicateSelectors)
	.then(duplicateSelectors => {
		console.log("duplicate selectors:", duplicateSelectors);
	})

async function findDuplicateSelectors(_mappingsCSS) {
	const Parser = (await import('css-simple-parser')).default;
	
	const mappingsCSS = removeComments(_mappingsCSS)
	const rbMappingsCSS = removeComments(fs.readFileSync(
		path.resolve(__dirname, '..', 'lib', '_rbMappings.scss'),
		'utf-8'
	));
	
	const clearvisSelectors = await getCSSSelectorSet(Parser, mappingsCSS)
	const rbSelectors = await getCSSSelectorSet(Parser, rbMappingsCSS)

	const diff = Array.from(clearvisSelectors.intersection(rbSelectors))
	return diff
}

function removeComments(scss) {
	return scss.split('\n').filter(line => !line.startsWith("//")).join('\n');
}

async function getCSSSelectorSet(parser, scss) {
	const selectorSet = new Set()
	const ast = parser.parse(scss)
	parser.traverse(ast, (node) => {
		selectorSet.add(node.selector.trim())
	})
	return selectorSet
}