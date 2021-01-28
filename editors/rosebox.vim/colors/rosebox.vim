" Vim color file: Rosebox
" Author: atidyshirt <jordanpyott@gmail.com>
" Source: https://github.com/atidyshirt/rosebox
" Description: This is rosebox theme based off of rayes0's Sayo theme
" Author Of Sayo: rayes0 <rayes@practicallyproductivity.com>
" Source For Sayo: https://github.com/rayes0/sayo

let g:colors_name="rosebox"
set background=dark

hi clear
if exists("syntax_on")
	syntax reset
endif



" Palette

let s:color0 = "#262626"
let s:color8 = "#3F3532"
let s:color1 = "#637A8A"
let s:color2 = "#a57562"
let s:color3 = "#6B8998"
let s:color4 = "#637A8A"
let s:color5 = "#877979"
let s:color6 = "#937F74"
let s:color7 = "#a3a5aa"
let s:conditional = '#637A8A'
let s:type = '#78758A'
let s:string = '#A3BE8C'
let s:int = '#D08770'
let s:char = '#D08770'
let s:comment = '#8F827C'

let s:color0_term = "0"
let s:color8_term = "8"
let s:color1_term = "1"
let s:color2_term = "2"
let s:color3_term = "3"
let s:color4_term = "4"
let s:color5_term = "5"
let s:color6_term = "6"
let s:color7_term = "7"


" Neovim colours
if has("nvim")
  let g:terminal_color_0 =  "#262626"
  let g:terminal_color_1 =  "#3F3532"
  let g:terminal_color_2 =  "#637A8A"
  let g:terminal_color_3 =  "#a57562"
  let g:terminal_color_4 =  "#569CD7"
  let g:terminal_color_5 =  "#877979"
  let g:terminal_color_6 =  "#937F74"
  let g:terminal_color_7 =  "#5e4c44"
  let g:terminal_color_8 =  "#262626"
  let g:terminal_color_9 =  "#222222"
  let g:terminal_color_10 = "#637A8A"
  let g:terminal_color_11 = "#a57562"
  let g:terminal_color_12 = "#8B8F7E"
  let g:terminal_color_13 = "#877979"
  let g:terminal_color_14 = "#937F74"
  let g:terminal_color_15 = "#5e4c44"
  let g:terminal_color_background = g:terminal_color_0
  let g:terminal_color_foreground = g:terminal_color_7
endif


" Highlighting
" Arguments: group, guifg, guibg, ctermfg, ctermbg, attr, guisp

function! s:hl(group, guifg, guibg, ctermfg, ctermbg, attr, guisp)
	if a:guifg != ""
		exec "hi " . a:group . " guifg=" . a:guifg
	endif
	if a:guibg != ""
		exec "hi " . a:group . " guibg=" . a:guibg
	endif
	if a:ctermfg != ""
		exec "hi " . a:group . " ctermfg=" . a:ctermfg
	endif
	if a:ctermbg != ""
		exec "hi " . a:group . " ctermbg=" . a:ctermbg
	endif
	if a:attr != ""
		exec "hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr
	endif
	if a:guisp != ""
		exec "hi " . a:group . " guisp=" . a:guisp
	endif
endfunction


" Groups
" Arguments: group, guifg, guibg, ctermfg, ctermbg, attr, guisp

" Editor
call s:hl("Normal", s:color7, "", s:color7_term, "", "", "")
call s:hl("Error", s:color0, s:color6, s:color0_term, s:color6_term, "bold", "")
call s:hl("ErrorMsg", s:color3, "", s:color3_term, "", "", "")
call s:hl("Cursor", s:color0, "", s:color0_term, "", "", "")
call s:hl("CursorColumn", "", s:color8, "", s:color8_term, "", "")
call s:hl("CursorLine", "", s:color8, "", s:color8_term, "none", "")
call s:hl("TabLine", s:color6, s:color8, s:color6_term, s:color8_term, "none", "")
call s:hl("TabLineSel", s:color4, s:color8, s:color4_term, s:color8_term, "bold", "")
call s:hl("TabLineFill", s:color8, s:color6, s:color8_term, s:color6_term, "", "")

call s:hl("LineNr", s:color6, "", s:color6_term, "", "", "")
call s:hl("SignColumn", s:color4, s:color8, s:color4_term, s:color8_term, "", "")
call s:hl("ColorColumn", "", s:color5_term, "", s:color5_term, "", "")

call s:hl("Pmenu", s:color7, s:color8, s:color7_term, s:color8_term, "", "")
call s:hl("PmenuSel", s:color4, s:color8, s:color4_term, s:color8_term, "bold", "")
call s:hl("PmenuSbar", "", "", "", "", "", "")
call s:hl("PmenuThumb", "", "", "", "", "", "")

call s:hl("SpellBad", s:color5, s:color8, s:color5_term, s:color8_term, "italic", "")
call s:hl("SpellCap", s:color5, s:color8, s:color5_term, s:color8_term, "italic", "")
call s:hl("SpellRare", s:color5, s:color8, s:color5_term, s:color8_term, "", "")
call s:hl("SpellLocal", s:color5, s:color8, s:color5_term, s:color8_term, "italic", "")

call s:hl("SpecialKey", s:color1, "", s:color1_term, "", "", "")
call s:hl("Directory", s:color4, "", s:color4_term, "", "bold", "")
call s:hl("ErrorMsg", s:color0, s:color2, s:color0_term, s:color2_term, "", "")
call s:hl("Search", s:color0, s:color6, s:color0_term, s:color6_term, "", "")
call s:hl("IncSearch", s:color0, s:color6, s:color0_term, s:color6_term, "", "")
call s:hl("MoreMsg", s:color4, "", s:color4_term, "", "", "")
call s:hl("ModeMsg", s:color6, "", s:color6_term, "", "", "")
call s:hl("Question", s:color3, "", s:color3_term, "", "", "")
call s:hl("StatusLine", s:color0, s:color6, s:color0_term, s:color6_term, "bold", "")
call s:hl("StatusLineNC", s:color0, s:color6, s:color0_term, s:color6_term, "bold", "")
call s:hl("VertSplit", s:color5, "", s:color5_term, "", "", "")
call s:hl("Title", s:color2, "", s:color2_term, "", "bold", "")
call s:hl("Visual", s:color7, s:color8, s:color7_term, s:color8_term, "", "")
call s:hl("WarningMsg", s:color1, "", s:color2_term, "", "", "")
call s:hl("Folded", s:color6, s:color8, s:color6_term, s:color8_term, "bold", "")
call s:hl("FoldColumn", s:color6, s:color8, s:color6_term, s:color8_term, "bold", "")


" Default Syntax
call s:hl("String", s:string, "", s:color8_term, "", "", "")
call s:hl("Comment", s:comment, "", s:color5_term, "", "", "")
call s:hl("Constant", s:color7, "", s:color7_term, "", "", "")
call s:hl("Identifier", s:color2, "", s:color2_term, "", "", "")
call s:hl("Statement", s:color3, "", s:color3_term, "", "", "")
call s:hl("PreProc", s:color1, "", s:color1_term, "", "", "")
call s:hl("Type", s:type, "", s:color8_term, "", "", "")
call s:hl("Special", s:color4, "", s:color4_term, "", "", "")
call s:hl("Conditional", s:conditional, "", s:color8_term, "", "", "")
call s:hl("Underlined", s:color2, "", s:color2_term, "", "underline", "")
call s:hl("Todo", s:color0, s:color3, s:color0_term, s:color3_term, "italic", "")
call s:hl("MatchParen", s:color0, s:color3, s:color0_term, s:color3_term, "", "")
call s:hl("Conceal", s:color3, "", s:color3_term, "", "", "")
call s:hl("NonText", s:color0, "", s:color0_term, "", "", "")
call s:hl("Boolean", s:int, "", s:color8_term, "", "", "")
call s:hl("Number", s:int, "", s:color8_term, "", "", "")
call s:hl("Float", s:int, "", s:color8_term, "", "", "")
call s:hl('Character', s:char, "", s:color8_term, "", "", "")


" Other Syntax

" Markdown
call s:hl("markdownHeadingDelimiter", s:color6, "", s:color6_term, "", "", "")
call s:hl("markdownH1", s:color3, "", s:color3_term, "", "bold", "")
call s:hl("markdownH2", s:color3, "", s:color3_term, "", "bold", "")
call s:hl("markdownH3", s:color2, "", s:color2_term, "", "bold", "")
call s:hl("markdownH4", s:color2, "", s:color2_term, "", "bold", "")
call s:hl("markdownH5", s:color2, "", s:color2_term, "", "", "")
call s:hl("markdownH6", s:color2, "", s:color2_term, "", "", "")

call s:hl("markdownItalic", "", "", "", "", "italic", "")
call s:hl("markdownBold", "", "", "", "", "bold", "")
call s:hl("markdownBoldItalic", "", "", "", "", "bold,italic", "")

call s:hl("markdownCodeDelimiter", s:color1, "", s:color1_term, "", "", "")
call s:hl("markdownCode", s:color6, "", s:color6_term, "", "", "")
call s:hl("markdownCodeBlock", s:color6, "", s:color6_term, "", "", "")

call s:hl("markdownError", s:color0, s:color6, s:color0_term, s:color6_term, "", "")

call s:hl("markdownUrl", s:color2, "", s:color2_term, "", "", "")
call s:hl("markdownAutomaticLink", s:color1, "", s:color1_term, "", "", "")

" HTML
call s:hl("htmlTag", s:color6, "", s:color6_term, "", "", "")
call s:hl("htmlEndTag", s:color6, "", s:color6_term, "", "", "")
call s:hl("htmlLink", s:color1, "", s:color1_term, "", "underline", "")
call s:hl("htmlScriptTag", s:color4, "", s:color4_term, "", "", "")
call s:hl("htmlSpecialTagName", s:color3, "", s:color3_term, "", "", "")

" Diff
call s:hl("DiffAdd", s:color3, s:color8, s:color3_term, s:color8_term, "", "")
call s:hl("DiffDelete", s:color5, s:color8, s:color4_term, s:color8_term, "", "")
call s:hl("DiffChange", s:color2, s:color8, s:color1_term, s:color8_term, "", "")
call s:hl("DiffText", s:color1, s:color8, s:color2_term, s:color8_term, "", "")

" CSS
call s:hl("cssBraces", s:color4, "", s:color4_term, "", "", "")
call s:hl("cssColor", s:color3, "", s:color3_term, "", "", "")

" JavaScript
call s:hl("javaScript", s:color4, "", s:color4_term, "", "", "")
call s:hl("javaScriptBraces", s:color4, "", s:color4_term, "", "","")

" Adding plugin support
" hi CursorLineNr term=bold ctermfg=2 gui=bold guifg=terminal_color_2
" let g:limelight_conceal_ctermfg = s:color8
" autocmd BufRead,BufNewFile *.py let python_highlight_all=1

" TODO: Add more language-specific highlight groups
