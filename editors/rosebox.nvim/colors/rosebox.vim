" ------------------------------------------------------------------------------------
" File: rosebox.vim
" Description: This is a fork of the gruvbox-community palette, that has been
" altered to fit the rosebox theme
" Author: morhetz <morhetz@gmail.com> | Forked by atidyshirt <jordanpyott@gmail.com>
" Original Source: https://github.com/gruvbox-community/gruvbox
" Source: https://github.com/atidyshirt/rosebox
" ------------------------------------------------------------------------------------

" Initialisation: {{{
if version > 580
  hi clear
  if exists("syntax_on")
    syntax reset
  endif
endif

let g:colors_name='rosebox'

if !(has('termguicolors') && &termguicolors) && !has('gui_running') && &t_Co != 256
  finish
endif

" }}}
" Global Settings: {{{

if !exists('g:rosebox_bold')
  let g:rosebox_bold=1
endif
if !exists('g:rosebox_italic')
  if has('gui_running') || $TERM_ITALICS == 'true'
    let g:rosebox_italic=1
  else
    let g:rosebox_italic=0
  endif
endif
if !exists('g:rosebox_undercurl')
  let g:rosebox_undercurl=1
endif
if !exists('g:rosebox_underline')
  let g:rosebox_underline=1
endif
if !exists('g:rosebox_inverse')
  let g:rosebox_inverse=1
endif

if !exists('g:rosebox_guisp_fallback') || index(['fg', 'bg'], g:rosebox_guisp_fallback) == -1
  let g:rosebox_guisp_fallback='NONE'
endif

if !exists('g:rosebox_improved_strings')
  let g:rosebox_improved_strings=0
endif

if !exists('g:rosebox_improved_warnings')
  let g:rosebox_improved_warnings=0
endif

if !exists('g:rosebox_termcolors')
  let g:rosebox_termcolors=256
endif

if !exists('g:rosebox_invert_indent_guides')
  let g:rosebox_invert_indent_guides=0
endif

if exists('g:rosebox_contrast')
  echo 'g:rosebox_contrast is deprecated; use g:rosebox_contrast_light and g:rosebox_contrast_dark instead'
endif

if !exists('g:rosebox_contrast_dark')
  let g:rosebox_contrast_dark='medium'
endif

if !exists('g:rosebox_contrast_light')
  let g:rosebox_contrast_light='medium'
endif

let s:is_dark=(&background == 'dark')

" }}}
" Palette Utility Functions: {{{

function! s:Color(name, default, ...)
  " color already set, validate option
  if has_key(s:gb, a:name)
    let l:color = s:gb[a:name]

    if type(l:color) == type('')
      " gui color only
      let s:gb[a:name] = copy(a:default)
      let s:gb[a:name][0] = l:color
      return 1
    elseif type(l:color) == type(0)
      " terminal color only
      let s:gb[a:name] = copy(a:default)
      let s:gb[a:name][1] = l:color
      return 1
    elseif type(l:color) == type([])
          \ && len(l:color) == 2
          \ && type(l:color[0]) == type('')
          \ && type(l:color[1]) == type(0)
      " gui and terminal color
      return 1
    else
      " invalid value
      echo a:name 'is invalid, usage: let g:rosebox_colors.color = (["#ffffff", 255]|"#ffffff"|255)'
      return 0
    endif

  endif

  " set default option
  let s:gb[a:name] = a:default
  return 1
endfunction

" }}}
" Palette: {{{

" get the global rosebox palette options, if any
let g:rosebox_colors = get(g:, 'rosebox_colors', {})
" initialize the script palette
let s:gb = copy(g:rosebox_colors)
let g:current_rosebox_colors = s:gb

" set palette default colors
call s:Color('dark0_hard',  ['#262626', 234])     " 29-32-33
call s:Color('dark0',       ['#262626', 235])     " 40-40-40
call s:Color('dark0_soft',  ['#262626', 236])     " 50-48-47
call s:Color('dark1',       ['#3c3836', 237])     " 60-56-54
call s:Color('dark2',       ['#504945', 239])     " 80-73-69
call s:Color('dark3',       ['#665c54', 241])     " 102-92-84
call s:Color('dark4',       ['#7c6f64', 243])     " 124-111-100
call s:Color('dark4_256',   ['#7c6f64', 243])     " 124-111-100

call s:Color('gray_245',    ['#8F827C', 245])     " 146-131-116
call s:Color('gray_244',    ['#8F827C', 244])     " 146-131-116

call s:Color('light0_hard', ['#f9f5d7', 230])     " 249-245-215
call s:Color('light0',      ['#fbf1c7', 229])     " 253-244-193
call s:Color('light0_soft', ['#f2e5bc', 228])     " 242-229-188
call s:Color('light1',      ['#ebdbb2', 223])     " 235-219-178
call s:Color('light2',      ['#d5c4a1', 250])     " 213-196-161
call s:Color('light3',      ['#bdae93', 248])     " 189-174-147
call s:Color('light4',      ['#a89984', 246])     " 168-153-132
call s:Color('light4_256',  ['#a89984', 246])     " 168-153-132

call s:Color('bright_red',     ['#D08770', 167])     " 251-73-52
call s:Color('bright_green',   ['#A3BE8C', 142])     " 184-187-38
call s:Color('bright_yellow',  ['#EBCB8B', 214])     " 250-189-47
call s:Color('bright_blue',    ['#637A8A', 109])     " 131-165-152
call s:Color('bright_purple',  ['#B48EAD', 175])     " 211-134-155
call s:Color('bright_aqua',    ['#8FBCBB', 108])     " 142-192-124
call s:Color('bright_orange',  ['#D08770', 208])     " 254-128-25

call s:Color('neutral_red',    ['#D08770', 124])     " 204-36-29
call s:Color('neutral_green',  ['#D08770', 106])     " 152-151-26
call s:Color('neutral_yellow', ['#EBCB8B', 172])     " 215-153-33
call s:Color('neutral_blue',   ['#637A8A', 66])      " 69-133-136
call s:Color('neutral_purple', ['#B48EAD', 132])     " 177-98-134
call s:Color('neutral_aqua',   ['#8FBCBB', 72])      " 104-157-106
call s:Color('neutral_orange', ['#D08770', 166])     " 214-93-14

call s:Color('faded_red',      ['#D08770', 88])      " 157-0-6
call s:Color('faded_green',    ['#A3BE8C', 100])     " 121-116-14
call s:Color('faded_yellow',   ['#b57614', 136])     " 181-118-20
call s:Color('faded_blue',     ['#637A8A', 24])      " 7-102-120
call s:Color('faded_purple',   ['#B48EAD', 96])      " 143-63-113
call s:Color('faded_aqua',     ['#8FBCBB', 65])      " 66-123-88
call s:Color('faded_orange',   ['#af3a03', 130])     " 175-58-3

" }}}
" Setup Emphasis: {{{

let s:bold = 'bold,'
if g:rosebox_bold == 0
  let s:bold = ''
endif

let s:italic = 'italic,'
if g:rosebox_italic == 0
  let s:italic = ''
endif

let s:underline = 'underline,'
if g:rosebox_underline == 0
  let s:underline = ''
endif

let s:undercurl = 'undercurl,'
if g:rosebox_undercurl == 0
  let s:undercurl = ''
endif

let s:inverse = 'inverse,'
if g:rosebox_inverse == 0
  let s:inverse = ''
endif

" }}}
" Setup Colors: {{{

let s:vim_bg = ['bg', 'bg']
let s:vim_fg = ['fg', 'fg']
let s:none = ['NONE', 'NONE']

" determine relative colors
if s:is_dark
  let s:bg0  = s:gb.dark0
  if g:rosebox_contrast_dark == 'soft'
    let s:bg0  = s:gb.dark0_soft
  elseif g:rosebox_contrast_dark == 'hard'
    let s:bg0  = s:gb.dark0_hard
  endif

  let s:bg1  = s:gb.dark1
  let s:bg2  = s:gb.dark2
  let s:bg3  = s:gb.dark3
  let s:bg4  = s:gb.dark4

  let s:gray = s:gb.gray_245

  let s:fg0 = s:gb.light0
  let s:fg1 = s:gb.light1
  let s:fg2 = s:gb.light2
  let s:fg3 = s:gb.light3
  let s:fg4 = s:gb.light4

  let s:fg4_256 = s:gb.light4_256

  let s:red    = s:gb.bright_red
  let s:green  = s:gb.bright_green
  let s:yellow = s:gb.bright_yellow
  let s:blue   = s:gb.bright_blue
  let s:purple = s:gb.bright_purple
  let s:aqua   = s:gb.bright_aqua
  let s:orange = s:gb.bright_orange
else
  let s:bg0  = s:gb.light0
  if g:rosebox_contrast_light == 'soft'
    let s:bg0  = s:gb.light0_soft
  elseif g:rosebox_contrast_light == 'hard'
    let s:bg0  = s:gb.light0_hard
  endif

  let s:bg1  = s:gb.light1
  let s:bg2  = s:gb.light2
  let s:bg3  = s:gb.light3
  let s:bg4  = s:gb.light4

  let s:gray = s:gb.gray_244

  let s:fg0 = s:gb.dark0
  let s:fg1 = s:gb.dark1
  let s:fg2 = s:gb.dark2
  let s:fg3 = s:gb.dark3
  let s:fg4 = s:gb.dark4

  let s:fg4_256 = s:gb.dark4_256

  let s:red    = s:gb.faded_red
  let s:green  = s:gb.faded_green
  let s:yellow = s:gb.faded_yellow
  let s:blue   = s:gb.faded_blue
  let s:purple = s:gb.faded_purple
  let s:aqua   = s:gb.faded_aqua
  let s:orange = s:gb.faded_orange
endif

" reset to 16 colors fallback
if g:rosebox_termcolors == 16
  let s:bg0[1]    = 0
  let s:fg4[1]    = 7
  let s:gray[1]   = 8
  let s:red[1]    = 9
  let s:green[1]  = 10
  let s:yellow[1] = 11
  let s:blue[1]   = 12
  let s:purple[1] = 13
  let s:aqua[1]   = 14
  let s:fg1[1]    = 15
endif

" save current relative colors back to palette dictionary
call s:Color('bg0', s:bg0)
call s:Color('bg1', s:bg1)
call s:Color('bg2', s:bg2)
call s:Color('bg3', s:bg3)
call s:Color('bg4', s:bg4)

call s:Color('gray', s:gray)

call s:Color('fg0', s:fg0)
call s:Color('fg1', s:fg1)
call s:Color('fg2', s:fg2)
call s:Color('fg3', s:fg3)
call s:Color('fg4', s:fg4)

call s:Color('fg4_256', s:fg4_256)

call s:Color('red',    s:red)
call s:Color('green',  s:green)
call s:Color('yellow', s:yellow)
call s:Color('blue',   s:blue)
call s:Color('purple', s:purple)
call s:Color('aqua',   s:aqua)
call s:Color('orange', s:orange)

" }}}
" Setup Terminal Colors For Neovim: {{{

if has('nvim')
  let g:terminal_color_0 = s:gb.bg0[0]
  let g:terminal_color_8 = s:gb.gray[0]

  let g:terminal_color_1 = s:gb.neutral_red[0]
  let g:terminal_color_9 = s:gb.red[0]

  let g:terminal_color_2 = s:gb.neutral_green[0]
  let g:terminal_color_10 = s:gb.green[0]

  let g:terminal_color_3 = s:gb.neutral_yellow[0]
  let g:terminal_color_11 = s:gb.yellow[0]

  let g:terminal_color_4 = s:gb.neutral_blue[0]
  let g:terminal_color_12 = s:gb.blue[0]

  let g:terminal_color_5 = s:gb.neutral_purple[0]
  let g:terminal_color_13 = s:gb.purple[0]

  let g:terminal_color_6 = s:gb.neutral_aqua[0]
  let g:terminal_color_14 = s:gb.aqua[0]

  let g:terminal_color_7 = s:gb.fg4[0]
  let g:terminal_color_15 = s:gb.fg1[0]
endif

" }}}
" Setup Terminal Colors For Vim with termguicolors: {{{

if exists('*term_setansicolors')
  let g:terminal_ansi_colors = repeat([0], 16)

  let g:terminal_ansi_colors[0] = s:gb.bg0[0]
  let g:terminal_ansi_colors[8] = s:gb.gray[0]

  let g:terminal_ansi_colors[1] = s:gb.neutral_red[0]
  let g:terminal_ansi_colors[9] = s:gb.red[0]

  let g:terminal_ansi_colors[2] = s:gb.neutral_green[0]
  let g:terminal_ansi_colors[10] = s:gb.green[0]

  let g:terminal_ansi_colors[3] = s:gb.neutral_yellow[0]
  let g:terminal_ansi_colors[11] = s:gb.yellow[0]

  let g:terminal_ansi_colors[4] = s:gb.neutral_blue[0]
  let g:terminal_ansi_colors[12] = s:gb.blue[0]

  let g:terminal_ansi_colors[5] = s:gb.neutral_purple[0]
  let g:terminal_ansi_colors[13] = s:gb.purple[0]

  let g:terminal_ansi_colors[6] = s:gb.neutral_aqua[0]
  let g:terminal_ansi_colors[14] = s:gb.aqua[0]

  let g:terminal_ansi_colors[7] = s:gb.fg4[0]
  let g:terminal_ansi_colors[15] = s:gb.fg1[0]
endif

" }}}
" Overload Setting: {{{

let s:hls_cursor = s:gb.orange
if exists('g:rosebox_hls_cursor')
  let s:hls_cursor = get(s:gb, g:rosebox_hls_cursor)
endif

let s:hls_highlight = s:gb.yellow
if exists('g:rosebox_hls_highlight')
  let s:hls_highlight = get(s:gb, g:rosebox_hls_highlight)
endif

let s:number_column = s:none
if exists('g:rosebox_number_column')
  let s:number_column = get(s:gb, g:rosebox_number_column)
endif

let s:sign_column = s:gb.bg0

if exists('g:rosebox_sign_column')
  let s:sign_column = get(s:gb, g:rosebox_sign_column)
endif

let s:color_column = s:gb.bg0
if exists('g:rosebox_color_column')
  let s:color_column = get(s:gb, g:rosebox_color_column)
endif

let s:vert_split = s:gb.bg0
if exists('g:rosebox_vert_split')
  let s:vert_split = get(s:gb, g:rosebox_vert_split)
endif

let s:invert_signs = ''
if exists('g:rosebox_invert_signs')
  if g:rosebox_invert_signs == 1
    let s:invert_signs = s:inverse
  endif
endif

let s:invert_selection = s:inverse
if exists('g:rosebox_invert_selection')
  if g:rosebox_invert_selection == 0
    let s:invert_selection = ''
  endif
endif

let s:invert_tabline = ''
if exists('g:rosebox_invert_tabline')
  if g:rosebox_invert_tabline == 1
    let s:invert_tabline = s:inverse
  endif
endif

let s:tabline_sel = s:gb.green
if exists('g:rosebox_tabline_sel')
  let s:tabline_sel = get(s:gb, g:rosebox_tabline_sel)
endif

let s:italicize_comments = s:italic
if exists('g:rosebox_italicize_comments')
  if g:rosebox_italicize_comments == 0
    let s:italicize_comments = ''
  endif
endif

let s:italicize_strings = ''
if exists('g:rosebox_italicize_strings')
  if g:rosebox_italicize_strings == 1
    let s:italicize_strings = s:italic
  endif
endif

" }}}
" Highlighting Function: {{{

function! s:HL(group, fg, ...)
  " Arguments: group, guifg, guibg, gui, guisp

  " foreground
  let fg = a:fg

  " background
  if a:0 >= 1
    let bg = a:1
  else
    let bg = s:none
  endif

  " emphasis
  if a:0 >= 2 && strlen(a:2)
    let emstr = a:2
  else
    let emstr = 'NONE,'
  endif

  " special fallback
  if a:0 >= 3
    if g:rosebox_guisp_fallback != 'NONE'
      let fg = a:3
    endif

    " bg fallback mode should invert higlighting
    if g:rosebox_guisp_fallback == 'bg'
      let emstr .= 'inverse,'
    endif
  endif

  let histring = [ 'hi', a:group,
        \ 'guifg=' . fg[0], 'ctermfg=' . fg[1],
        \ 'guibg=' . bg[0], 'ctermbg=' . bg[1],
        \ 'gui=' . emstr[:-2], 'cterm=' . emstr[:-2]
        \ ]

  " special
  if a:0 >= 3
    call add(histring, 'guisp=' . a:3[0])
  endif

  execute join(histring, ' ')
endfunction

" }}}
" Rosebox Hi Groups: {{{

" memoize common hi groups
call s:HL('RoseboxFg0', s:gb.fg0)
call s:HL('RoseboxFg1', s:gb.fg1)
call s:HL('RoseboxFg2', s:gb.fg2)
call s:HL('RoseboxFg3', s:gb.fg3)
call s:HL('RoseboxFg4', s:gb.fg4)
call s:HL('RoseboxGray', s:gb.gray)
call s:HL('RoseboxBg0', s:gb.bg0)
call s:HL('RoseboxBg1', s:gb.bg1)
call s:HL('RoseboxBg2', s:gb.bg2)
call s:HL('RoseboxBg3', s:gb.bg3)
call s:HL('RoseboxBg4', s:gb.bg4)

call s:HL('RoseboxRed', s:gb.red)
call s:HL('RoseboxRedBold', s:gb.red, s:none, s:bold)
call s:HL('RoseboxGreen', s:gb.green)
call s:HL('RoseboxGreenBold', s:gb.green, s:none, s:bold)
call s:HL('RoseboxYellow', s:gb.yellow)
call s:HL('RoseboxYellowBold', s:gb.yellow, s:none, s:bold)
call s:HL('RoseboxBlue', s:gb.blue)
call s:HL('RoseboxBlueBold', s:gb.blue, s:none, s:bold)
call s:HL('RoseboxPurple', s:gb.purple)
call s:HL('RoseboxPurpleBold', s:gb.purple, s:none, s:bold)
call s:HL('RoseboxAqua', s:gb.aqua)
call s:HL('RoseboxAquaBold', s:gb.aqua, s:none, s:bold)
call s:HL('RoseboxOrange', s:gb.orange)
call s:HL('RoseboxOrangeBold', s:gb.orange, s:none, s:bold)

call s:HL('RoseboxRedSign', s:gb.red, s:sign_column, s:invert_signs)
call s:HL('RoseboxGreenSign', s:gb.green, s:sign_column, s:invert_signs)
call s:HL('RoseboxYellowSign', s:gb.yellow, s:sign_column, s:invert_signs)
call s:HL('RoseboxBlueSign', s:gb.blue, s:sign_column, s:invert_signs)
call s:HL('RoseboxPurpleSign', s:gb.purple, s:sign_column, s:invert_signs)
call s:HL('RoseboxAquaSign', s:gb.aqua, s:sign_column, s:invert_signs)
call s:HL('RoseboxOrangeSign', s:gb.orange, s:sign_column, s:invert_signs)

call s:HL('RoseboxRedUnderline', s:none, s:none, s:undercurl, s:gb.red)
call s:HL('RoseboxGreenUnderline', s:none, s:none, s:undercurl, s:gb.green)
call s:HL('RoseboxYellowUnderline', s:none, s:none, s:undercurl, s:gb.yellow)
call s:HL('RoseboxBlueUnderline', s:none, s:none, s:undercurl, s:gb.blue)
call s:HL('RoseboxPurpleUnderline', s:none, s:none, s:undercurl, s:gb.purple)
call s:HL('RoseboxAquaUnderline', s:none, s:none, s:undercurl, s:gb.aqua)
call s:HL('RoseboxOrangeUnderline', s:none, s:none, s:undercurl, s:gb.orange)

" }}}

" Vanilla colorscheme ---------------------------------------------------------
" General UI: {{{

" Normal text
call s:HL('Normal', s:gb.fg1, s:gb.bg0)

" Correct background (see issue #7):
" --- Problem with changing between dark and light on 256 color terminal
" --- https://github.com/morhetz/rosebox/issues/7
if exists('v:vim_did_enter')
  let g:rosebox_vim_did_enter = v:vim_did_enter
else
  augroup RoseboxVimEnter
    au!
    autocmd VimEnter * let g:rosebox_vim_did_enter = 1
  augroup End
endif
if get(g:, 'rosebox_vim_did_enter', 0)
  if s:is_dark
    set background=dark
  else
    set background=light
  endif
endif

if version >= 700
  " Screen line that the cursor is
  call s:HL('CursorLine',   s:none, s:gb.bg1)
  " Screen column that the cursor is
  hi! link CursorColumn CursorLine

  " Tab pages line filler
  call s:HL('TabLineFill', s:gb.bg4, s:gb.bg1, s:invert_tabline)
  " Active tab page label
  call s:HL('TabLineSel', s:tabline_sel, s:gb.bg1, s:invert_tabline)
  " Not active tab page label
  hi! link TabLine TabLineFill

  " Match paired bracket under the cursor
  call s:HL('MatchParen', s:none, s:gb.bg3, s:bold)
endif

if version >= 703
  " Highlighted screen columns
  call s:HL('ColorColumn',  s:none, s:color_column)

  " Concealed element: \lambda → λ
  call s:HL('Conceal', s:gb.blue, s:none)

  " Line number of CursorLine
  call s:HL('CursorLineNr', s:gb.yellow, s:gb.bg1)
endif

hi! link NonText RoseboxBg2
hi! link SpecialKey RoseboxFg4

call s:HL('Visual',    s:none,  s:gb.bg3, s:invert_selection)
hi! link VisualNOS Visual

call s:HL('Search', s:hls_highlight, s:gb.bg0, s:inverse)
call s:HL('IncSearch', s:hls_cursor, s:gb.bg0, s:inverse)

call s:HL('QuickFixLine', s:gb.bg0, s:gb.yellow, s:bold)

call s:HL('Underlined', s:gb.blue, s:none, s:underline)

call s:HL('StatusLine',   s:gb.bg2, s:gb.fg1, s:inverse)
call s:HL('StatusLineNC', s:gb.bg1, s:gb.fg4, s:inverse)

" The column separating vertically split windows
call s:HL('VertSplit', s:gb.bg3, s:vert_split)

" Current match in wildmenu completion
call s:HL('WildMenu', s:gb.blue, s:gb.bg2, s:bold)

" Directory names, special names in listing
hi! link Directory RoseboxGreenBold

" Titles for output from :set all, :autocmd, etc.
hi! link Title RoseboxGreenBold

" Error messages on the command line
call s:HL('ErrorMsg',   s:gb.bg0, s:gb.red, s:bold)
" More prompt: -- More --
hi! link MoreMsg RoseboxYellowBold
" Current mode message: -- INSERT --
hi! link ModeMsg RoseboxYellowBold
" 'Press enter' prompt and yes/no questions
hi! link Question RoseboxOrangeBold
" Warning messages
hi! link WarningMsg RoseboxRedBold

" }}}
" Gutter: {{{

" Line number for :number and :# commands
call s:HL('LineNr', s:gb.bg4, s:number_column)

" Column where signs are displayed
call s:HL('SignColumn', s:none, s:sign_column)

" Line used for closed folds
call s:HL('Folded', s:gb.gray, s:gb.bg1, s:italic)
" Column where folds are displayed
call s:HL('FoldColumn', s:gb.gray, s:gb.bg1)

" }}}
" Cursor: {{{

" Character under cursor
call s:HL('Cursor', s:none, s:none, s:inverse)
" Visual mode cursor, selection
hi! link vCursor Cursor
" Input moder cursor
hi! link iCursor Cursor
" Language mapping cursor
hi! link lCursor Cursor

" }}}
" Syntax Highlighting: {{{

if g:rosebox_improved_strings == 0
  hi! link Special RoseboxOrange
else
  call s:HL('Special', s:gb.orange, s:gb.bg1, s:italicize_strings)
endif

call s:HL('Comment', s:gb.gray, s:none, s:italicize_comments)
call s:HL('Todo', s:vim_fg, s:none, s:bold . s:italic)
call s:HL('Error', s:gb.red, s:none, s:bold . s:inverse)

" Generic statement
hi! link Statement RoseboxRed
" if, then, else, endif, swicth, etc.
hi! link Conditional RoseboxRed
" for, do, while, etc.
hi! link Repeat RoseboxRed
" case, default, etc.
hi! link Label RoseboxRed
" try, catch, throw
hi! link Exception RoseboxRed
" sizeof, "+", "*", etc.
hi! link Operator RoseboxFg1
" Any other keyword
hi! link Keyword RoseboxRed

" Variable name
hi! link Identifier RoseboxBlue
" Function name
hi! link Function RoseboxGreenBold

" Generic preprocessor
hi! link PreProc RoseboxAqua
" Preprocessor #include
hi! link Include RoseboxAqua
" Preprocessor #define
hi! link Define RoseboxAqua
" Same as Define
hi! link Macro RoseboxAqua
" Preprocessor #if, #else, #endif, etc.
hi! link PreCondit RoseboxAqua

" Generic constant
hi! link Constant RoseboxPurple
" Character constant: 'c', '/n'
hi! link Character RoseboxPurple
" String constant: "this is a string"
if g:rosebox_improved_strings == 0
  call s:HL('String',  s:gb.green, s:none, s:italicize_strings)
else
  call s:HL('String',  s:gb.fg1, s:gb.bg1, s:italicize_strings)
endif
" Boolean constant: TRUE, false
hi! link Boolean RoseboxPurple
" Number constant: 234, 0xff
hi! link Number RoseboxPurple
" Floating point constant: 2.3e10
hi! link Float RoseboxPurple

" Generic type
hi! link Type RoseboxYellow
" static, register, volatile, etc
hi! link StorageClass RoseboxOrange
" struct, union, enum, etc.
hi! link Structure RoseboxAqua
" typedef
hi! link Typedef RoseboxYellow

" }}}
" Completion Menu: {{{

if version >= 700
  " Popup menu: normal item
  call s:HL('Pmenu', s:gb.fg1, s:gb.bg2)
  " Popup menu: selected item
  call s:HL('PmenuSel', s:gb.bg2, s:gb.blue, s:bold)
  " Popup menu: scrollbar
  call s:HL('PmenuSbar', s:none, s:gb.bg2)
  " Popup menu: scrollbar thumb
  call s:HL('PmenuThumb', s:none, s:gb.bg4)
endif

" }}}
" Diffs: {{{

call s:HL('DiffDelete', s:gb.red, s:gb.bg0, s:inverse)
call s:HL('DiffAdd',    s:gb.green, s:gb.bg0, s:inverse)
"call s:HL('DiffChange', s:gb.bg0, s:gb.blue)
"call s:HL('DiffText',   s:gb.bg0, s:gb.yellow)

" Alternative setting
call s:HL('DiffChange', s:gb.aqua, s:gb.bg0, s:inverse)
call s:HL('DiffText',   s:gb.yellow, s:gb.bg0, s:inverse)

" }}}
" Spelling: {{{

if has("spell")
  " Not capitalised word, or compile warnings
  if g:rosebox_improved_warnings == 0
    hi! link SpellCap RoseboxBlueUnderline
  else
    call s:HL('SpellCap',   s:gb.green, s:none, s:bold . s:italic)
  endif
  " Not recognized word
  hi! link SpellBad RoseboxRedUnderline
  " Wrong spelling for selected region
  hi! link SpellLocal RoseboxAquaUnderline
  " Rare word
  hi! link SpellRare RoseboxPurpleUnderline
endif

" }}}
" LSP: {{{

hi! link LspDiagnosticsDefaultError RoseboxRed
hi! link LspDiagnosticsSignError RoseboxRedSign
hi! link LspDiagnosticsUnderlineError RoseboxRedUnderline

hi! link LspDiagnosticsDefaultWarning RoseboxYellow
hi! link LspDiagnosticsSignWarning RoseboxYellowSign
hi! link LspDiagnosticsUnderlineWarning RoseboxYellowUnderline

hi! link LspDiagnosticsDefaultInformation RoseboxBlue
hi! link LspDiagnosticsSignInformation RoseboxBlueSign
hi! link LspDiagnosticsUnderlineInformation RoseboxBlueUnderline

hi! link LspDiagnosticsDefaultHint RoseboxAqua
hi! link LspDiagnosticsSignHint RoseboxAquaSign
hi! link LspDiagnosticsUnderlineHint RoseboxAquaUnderline

hi! link LspReferenceText RoseboxYellowBold
hi! link LspReferenceRead RoseboxYellowBold
hi! link LspReferenceWrite RoseboxOrangeBold

" }}}

" Plugin specific -------------------------------------------------------------
" EasyMotion: {{{

hi! link EasyMotionTarget RoseboxRedBold
hi! link EasyMotionTarget2First RoseboxYellowBold
hi! link EasyMotionTarget2Second RoseboxOrangeBold
hi! link EasyMotionShade RoseboxGray

" }}}
" Sneak: {{{

hi! link Sneak Search
hi! link SneakLabel Search

" }}}
" Indent Guides: {{{

if !exists('g:indent_guides_auto_colors')
  let g:indent_guides_auto_colors = 0
endif

if g:indent_guides_auto_colors == 0
  if g:rosebox_invert_indent_guides == 0
    call s:HL('IndentGuidesOdd', s:vim_bg, s:gb.bg2)
    call s:HL('IndentGuidesEven', s:vim_bg, s:gb.bg1)
  else
    call s:HL('IndentGuidesOdd', s:vim_bg, s:gb.bg2, s:inverse)
    call s:HL('IndentGuidesEven', s:vim_bg, s:gb.bg3, s:inverse)
  endif
endif

" }}}
" IndentLine: {{{

if !exists('g:indentLine_color_term')
  let g:indentLine_color_term = s:gb.bg2[1]
endif
if !exists('g:indentLine_color_gui')
  let g:indentLine_color_gui = s:gb.bg2[0]
endif

" }}}
" Rainbow Parentheses: {{{

if !exists('g:rbpt_colorpairs')
  let g:rbpt_colorpairs =
    \ [
      \ ['blue', '#458588'], ['magenta', '#b16286'],
      \ ['red',  '#cc241d'], ['166',     '#d65d0e']
    \ ]
endif

let g:rainbow_guifgs = [ '#d65d0e', '#cc241d', '#b16286', '#458588' ]
let g:rainbow_ctermfgs = [ '166', 'red', 'magenta', 'blue' ]

if !exists('g:rainbow_conf')
   let g:rainbow_conf = {}
endif
if !has_key(g:rainbow_conf, 'guifgs')
   let g:rainbow_conf['guifgs'] = g:rainbow_guifgs
endif
if !has_key(g:rainbow_conf, 'ctermfgs')
   let g:rainbow_conf['ctermfgs'] = g:rainbow_ctermfgs
endif

let g:niji_dark_colours = g:rbpt_colorpairs
let g:niji_light_colours = g:rbpt_colorpairs

"}}}
" GitGutter: {{{

hi! link GitGutterAdd RoseboxGreenSign
hi! link GitGutterChange RoseboxAquaSign
hi! link GitGutterDelete RoseboxRedSign
hi! link GitGutterChangeDelete RoseboxAquaSign

" }}}
" GitCommit: "{{{

hi! link gitcommitSelectedFile RoseboxGreen
hi! link gitcommitDiscardedFile RoseboxRed

" }}}
" Signify: {{{

hi! link SignifySignAdd RoseboxGreenSign
hi! link SignifySignChange RoseboxAquaSign
hi! link SignifySignDelete RoseboxRedSign

" }}}
" gitsigns.nvim {{{
hi! link GitSignsAdd RoseboxGreenSign
hi! link GitSignsChange RoseboxAquaSign
hi! link GitSignsDelete RoseboxRedSign
" }}}
" Syntastic: {{{

hi! link SyntasticError RoseboxRedUnderline
hi! link SyntasticWarning RoseboxYellowUnderline

hi! link SyntasticErrorSign RoseboxRedSign
hi! link SyntasticWarningSign RoseboxYellowSign

" }}}
" Termdebug: {{{

call s:HL('debugPC', s:none, s:gb.faded_blue)
hi! link debugBreakpoint RoseboxRedSign

" }}}

" Signature: {{{
hi! link SignatureMarkText   RoseboxBlueSign
hi! link SignatureMarkerText RoseboxPurpleSign

" }}}
" ShowMarks: {{{

hi! link ShowMarksHLl RoseboxBlueSign
hi! link ShowMarksHLu RoseboxBlueSign
hi! link ShowMarksHLo RoseboxBlueSign
hi! link ShowMarksHLm RoseboxBlueSign

" }}}
" CtrlP: {{{

hi! link CtrlPMatch RoseboxYellow
hi! link CtrlPNoEntries RoseboxRed
hi! link CtrlPPrtBase RoseboxBg2
hi! link CtrlPPrtCursor RoseboxBlue
hi! link CtrlPLinePre RoseboxBg2

call s:HL('CtrlPMode1', s:gb.blue, s:gb.bg2, s:bold)
call s:HL('CtrlPMode2', s:gb.bg0, s:gb.blue, s:bold)
call s:HL('CtrlPStats', s:gb.fg4, s:gb.bg2, s:bold)

" }}}
" FZF: {{{

let g:fzf_colors = {
      \ 'fg':      ['fg', 'RoseboxFg1'],
      \ 'bg':      ['fg', 'RoseboxBg0'],
      \ 'hl':      ['fg', 'RoseboxYellow'],
      \ 'fg+':     ['fg', 'RoseboxFg1'],
      \ 'bg+':     ['fg', 'RoseboxBg1'],
      \ 'hl+':     ['fg', 'RoseboxYellow'],
      \ 'info':    ['fg', 'RoseboxBlue'],
      \ 'prompt':  ['fg', 'RoseboxFg4'],
      \ 'pointer': ['fg', 'RoseboxBlue'],
      \ 'marker':  ['fg', 'RoseboxOrange'],
      \ 'spinner': ['fg', 'RoseboxYellow'],
      \ 'header':  ['fg', 'RoseboxBg3']
      \ }

call s:HL('Fzf1', s:gb.blue, s:gb.bg1)
call s:HL('Fzf2', s:gb.orange, s:gb.bg1)
call s:HL('Fzf3', s:gb.fg4, s:gb.bg1)

" }}}
" Startify: {{{

hi! link StartifyBracket RoseboxFg3
hi! link StartifyFile RoseboxFg1
hi! link StartifyNumber RoseboxBlue
hi! link StartifyPath RoseboxGray
hi! link StartifySlash RoseboxGray
hi! link StartifySection RoseboxYellow
hi! link StartifySpecial RoseboxBg2
hi! link StartifyHeader RoseboxOrange
hi! link StartifyFooter RoseboxBg2

" }}}
" Vimshell: {{{

let g:vimshell_escape_colors = [
  \ s:gb.bg4[0], s:gb.red[0], s:gb.green[0], s:gb.yellow[0],
  \ s:gb.blue[0], s:gb.purple[0], s:gb.aqua[0], s:gb.fg4[0],
  \ s:gb.bg0[0], s:gb.red[0], s:gb.green[0], s:gb.orange[0],
  \ s:gb.blue[0], s:gb.purple[0], s:gb.aqua[0], s:gb.fg0[0]
  \ ]

" }}}
" BufTabLine: {{{

call s:HL('BufTabLineCurrent', s:gb.bg0, s:gb.fg4)
call s:HL('BufTabLineActive', s:gb.fg4, s:gb.bg2)
call s:HL('BufTabLineHidden', s:gb.bg4, s:gb.bg1)
call s:HL('BufTabLineFill', s:gb.bg0, s:gb.bg0)

" }}}
" Asynchronous Lint Engine: {{{

hi! link ALEError RoseboxRedUnderline
hi! link ALEWarning RoseboxYellowUnderline
hi! link ALEInfo RoseboxBlueUnderline

hi! link ALEErrorSign RoseboxRedSign
hi! link ALEWarningSign RoseboxYellowSign
hi! link ALEInfoSign RoseboxBlueSign

hi! link ALEVirtualTextError RoseboxRed
hi! link ALEVirtualTextWarning RoseboxYellow
hi! link ALEVirtualTextInfo RoseboxBlue

" }}}
" Dirvish: {{{

hi! link DirvishPathTail RoseboxAqua
hi! link DirvishArg RoseboxYellow

" }}}
" Netrw: {{{

hi! link netrwDir RoseboxAqua
hi! link netrwClassify RoseboxAqua
hi! link netrwLink RoseboxGray
hi! link netrwSymLink RoseboxFg1
hi! link netrwExe RoseboxYellow
hi! link netrwComment RoseboxGray
hi! link netrwList RoseboxBlue
hi! link netrwHelpCmd RoseboxAqua
hi! link netrwCmdSep RoseboxFg3
hi! link netrwVersion RoseboxGreen

" }}}
" NERDTree: {{{

hi! link NERDTreeDir RoseboxAqua
hi! link NERDTreeDirSlash RoseboxAqua

hi! link NERDTreeOpenable RoseboxOrange
hi! link NERDTreeClosable RoseboxOrange

hi! link NERDTreeFile RoseboxFg1
hi! link NERDTreeExecFile RoseboxYellow

hi! link NERDTreeUp RoseboxGray
hi! link NERDTreeCWD RoseboxGreen
hi! link NERDTreeHelp RoseboxFg1

hi! link NERDTreeToggleOn RoseboxGreen
hi! link NERDTreeToggleOff RoseboxRed

" }}}
" Vim Multiple Cursors: {{{

call s:HL('multiple_cursors_cursor', s:none, s:none, s:inverse)
call s:HL('multiple_cursors_visual', s:none, s:gb.bg2)

" }}}
" coc.nvim: {{{

hi! link CocErrorSign RoseboxRedSign
hi! link CocWarningSign RoseboxOrangeSign
hi! link CocInfoSign RoseboxBlueSign
hi! link CocHintSign RoseboxAquaSign
hi! link CocErrorFloat RoseboxRed
hi! link CocWarningFloat RoseboxOrange
hi! link CocInfoFloat RoseboxBlue
hi! link CocHintFloat RoseboxAqua
hi! link CocDiagnosticsError RoseboxRed
hi! link CocDiagnosticsWarning RoseboxOrange
hi! link CocDiagnosticsInfo RoseboxBlue
hi! link CocDiagnosticsHint RoseboxAqua

hi! link CocSelectedText RoseboxRed
hi! link CocCodeLens RoseboxGray

hi! link CocErrorHighlight RoseboxRedUnderline
hi! link CocWarningHighlight RoseboxOrangeUnderline
hi! link CocInfoHighlight RoseboxBlueUnderline
hi! link CocHintHighlight RoseboxAquaUnderline

" }}}
" Telescope.nvim: {{{
hi! link TelescopeNormal RoseboxFg1
hi! link TelescopeSelection RoseboxOrangeBold
hi! link TelescopeSlectionCaret RoseboxRed
hi! link TelescopeMultiSelection RoseboxGray
hi! link TelescopeBorder TelescopeNormal
hi! link TelescopePromptBorder TelescopeNormal
hi! link TelescopeResultsBorder TelescopeNormal
hi! link TelescopePreviewBorder TelescopeNormal
hi! link TelescopeMatching RoseboxBlue
hi! link TelescopePromptPrefix RoseboxRed
hi! link TelescopePrompt TelescopeNormal

" }}}

" Filetype specific -----------------------------------------------------------
" Diff: {{{

hi! link diffAdded RoseboxGreen
hi! link diffRemoved RoseboxRed
hi! link diffChanged RoseboxAqua

hi! link diffFile RoseboxOrange
hi! link diffNewFile RoseboxYellow

hi! link diffLine RoseboxBlue

" }}}
" Html: {{{

hi! link htmlTag RoseboxAquaBold
hi! link htmlEndTag RoseboxAquaBold

hi! link htmlTagName RoseboxBlue
hi! link htmlArg RoseboxOrange

hi! link htmlTagN RoseboxFg1
hi! link htmlSpecialTagName RoseboxBlue

call s:HL('htmlLink', s:gb.fg4, s:none, s:underline)

hi! link htmlSpecialChar RoseboxRed

call s:HL('htmlBold', s:vim_fg, s:vim_bg, s:bold)
call s:HL('htmlBoldUnderline', s:vim_fg, s:vim_bg, s:bold . s:underline)
call s:HL('htmlBoldItalic', s:vim_fg, s:vim_bg, s:bold . s:italic)
call s:HL('htmlBoldUnderlineItalic', s:vim_fg, s:vim_bg, s:bold . s:underline . s:italic)

call s:HL('htmlUnderline', s:vim_fg, s:vim_bg, s:underline)
call s:HL('htmlUnderlineItalic', s:vim_fg, s:vim_bg, s:underline . s:italic)
call s:HL('htmlItalic', s:vim_fg, s:vim_bg, s:italic)

" }}}
" Xml: {{{

hi! link xmlTag RoseboxAquaBold
hi! link xmlEndTag RoseboxAquaBold
hi! link xmlTagName RoseboxBlue
hi! link xmlEqual RoseboxBlue
hi! link docbkKeyword RoseboxAquaBold

hi! link xmlDocTypeDecl RoseboxGray
hi! link xmlDocTypeKeyword RoseboxPurple
hi! link xmlCdataStart RoseboxGray
hi! link xmlCdataCdata RoseboxPurple
hi! link dtdFunction RoseboxGray
hi! link dtdTagName RoseboxPurple

hi! link xmlAttrib RoseboxOrange
hi! link xmlProcessingDelim RoseboxGray
hi! link dtdParamEntityPunct RoseboxGray
hi! link dtdParamEntityDPunct RoseboxGray
hi! link xmlAttribPunct RoseboxGray

hi! link xmlEntity RoseboxRed
hi! link xmlEntityPunct RoseboxRed
" }}}
" Vim: {{{

call s:HL('vimCommentTitle', s:gb.fg4_256, s:none, s:bold . s:italicize_comments)

hi! link vimNotation RoseboxOrange
hi! link vimBracket RoseboxOrange
hi! link vimMapModKey RoseboxOrange
hi! link vimFuncSID RoseboxFg3
hi! link vimSetSep RoseboxFg3
hi! link vimSep RoseboxFg3
hi! link vimContinue RoseboxFg3

" }}}
" Clojure: {{{

hi! link clojureKeyword RoseboxBlue
hi! link clojureCond RoseboxOrange
hi! link clojureSpecial RoseboxOrange
hi! link clojureDefine RoseboxOrange

hi! link clojureFunc RoseboxYellow
hi! link clojureRepeat RoseboxYellow
hi! link clojureCharacter RoseboxAqua
hi! link clojureStringEscape RoseboxAqua
hi! link clojureException RoseboxRed

hi! link clojureRegexp RoseboxAqua
hi! link clojureRegexpEscape RoseboxAqua
call s:HL('clojureRegexpCharClass', s:gb.fg3, s:none, s:bold)
hi! link clojureRegexpMod clojureRegexpCharClass
hi! link clojureRegexpQuantifier clojureRegexpCharClass

hi! link clojureParen RoseboxFg3
hi! link clojureAnonArg RoseboxYellow
hi! link clojureVariable RoseboxBlue
hi! link clojureMacro RoseboxOrange

hi! link clojureMeta RoseboxYellow
hi! link clojureDeref RoseboxYellow
hi! link clojureQuote RoseboxYellow
hi! link clojureUnquote RoseboxYellow

" }}}
" C: {{{

hi! link cOperator RoseboxPurple
hi! link cppOperator RoseboxPurple
hi! link cStructure RoseboxOrange

" }}}
" Python: {{{

hi! link pythonBuiltin RoseboxOrange
hi! link pythonBuiltinObj RoseboxOrange
hi! link pythonBuiltinFunc RoseboxOrange
hi! link pythonFunction RoseboxAqua
hi! link pythonDecorator RoseboxRed
hi! link pythonInclude RoseboxBlue
hi! link pythonImport RoseboxBlue
hi! link pythonRun RoseboxBlue
hi! link pythonCoding RoseboxBlue
hi! link pythonOperator RoseboxRed
hi! link pythonException RoseboxRed
hi! link pythonExceptions RoseboxPurple
hi! link pythonBoolean RoseboxPurple
hi! link pythonDot RoseboxFg3
hi! link pythonConditional RoseboxRed
hi! link pythonRepeat RoseboxRed
hi! link pythonDottedName RoseboxGreenBold

" }}}
" CSS: {{{

hi! link cssBraces RoseboxBlue
hi! link cssFunctionName RoseboxYellow
hi! link cssIdentifier RoseboxOrange
hi! link cssClassName RoseboxGreen
hi! link cssColor RoseboxBlue
hi! link cssSelectorOp RoseboxBlue
hi! link cssSelectorOp2 RoseboxBlue
hi! link cssImportant RoseboxGreen
hi! link cssVendor RoseboxFg1

hi! link cssTextProp RoseboxAqua
hi! link cssAnimationProp RoseboxAqua
hi! link cssUIProp RoseboxYellow
hi! link cssTransformProp RoseboxAqua
hi! link cssTransitionProp RoseboxAqua
hi! link cssPrintProp RoseboxAqua
hi! link cssPositioningProp RoseboxYellow
hi! link cssBoxProp RoseboxAqua
hi! link cssFontDescriptorProp RoseboxAqua
hi! link cssFlexibleBoxProp RoseboxAqua
hi! link cssBorderOutlineProp RoseboxAqua
hi! link cssBackgroundProp RoseboxAqua
hi! link cssMarginProp RoseboxAqua
hi! link cssListProp RoseboxAqua
hi! link cssTableProp RoseboxAqua
hi! link cssFontProp RoseboxAqua
hi! link cssPaddingProp RoseboxAqua
hi! link cssDimensionProp RoseboxAqua
hi! link cssRenderProp RoseboxAqua
hi! link cssColorProp RoseboxAqua
hi! link cssGeneratedContentProp RoseboxAqua

" }}}
" JavaScript: {{{

hi! link javaScriptBraces RoseboxFg1
hi! link javaScriptFunction RoseboxAqua
hi! link javaScriptIdentifier RoseboxRed
hi! link javaScriptMember RoseboxBlue
hi! link javaScriptNumber RoseboxPurple
hi! link javaScriptNull RoseboxPurple
hi! link javaScriptParens RoseboxFg3

" }}}
" YAJS: {{{

hi! link javascriptImport RoseboxAqua
hi! link javascriptExport RoseboxAqua
hi! link javascriptClassKeyword RoseboxAqua
hi! link javascriptClassExtends RoseboxAqua
hi! link javascriptDefault RoseboxAqua

hi! link javascriptClassName RoseboxYellow
hi! link javascriptClassSuperName RoseboxYellow
hi! link javascriptGlobal RoseboxYellow

hi! link javascriptEndColons RoseboxFg1
hi! link javascriptFuncArg RoseboxFg1
hi! link javascriptGlobalMethod RoseboxFg1
hi! link javascriptNodeGlobal RoseboxFg1
hi! link javascriptBOMWindowProp RoseboxFg1
hi! link javascriptArrayMethod RoseboxFg1
hi! link javascriptArrayStaticMethod RoseboxFg1
hi! link javascriptCacheMethod RoseboxFg1
hi! link javascriptDateMethod RoseboxFg1
hi! link javascriptMathStaticMethod RoseboxFg1

" hi! link javascriptProp RoseboxFg1
hi! link javascriptURLUtilsProp RoseboxFg1
hi! link javascriptBOMNavigatorProp RoseboxFg1
hi! link javascriptDOMDocMethod RoseboxFg1
hi! link javascriptDOMDocProp RoseboxFg1
hi! link javascriptBOMLocationMethod RoseboxFg1
hi! link javascriptBOMWindowMethod RoseboxFg1
hi! link javascriptStringMethod RoseboxFg1

hi! link javascriptVariable RoseboxOrange
" hi! link javascriptVariable RoseboxRed
" hi! link javascriptIdentifier RoseboxOrange
" hi! link javascriptClassSuper RoseboxOrange
hi! link javascriptIdentifier RoseboxOrange
hi! link javascriptClassSuper RoseboxOrange

" hi! link javascriptFuncKeyword RoseboxOrange
" hi! link javascriptAsyncFunc RoseboxOrange
hi! link javascriptFuncKeyword RoseboxAqua
hi! link javascriptAsyncFunc RoseboxAqua
hi! link javascriptClassStatic RoseboxOrange

hi! link javascriptOperator RoseboxRed
hi! link javascriptForOperator RoseboxRed
hi! link javascriptYield RoseboxRed
hi! link javascriptExceptions RoseboxRed
hi! link javascriptMessage RoseboxRed

hi! link javascriptTemplateSB RoseboxAqua
hi! link javascriptTemplateSubstitution RoseboxFg1

" hi! link javascriptLabel RoseboxBlue
" hi! link javascriptObjectLabel RoseboxBlue
" hi! link javascriptPropertyName RoseboxBlue
hi! link javascriptLabel RoseboxFg1
hi! link javascriptObjectLabel RoseboxFg1
hi! link javascriptPropertyName RoseboxFg1

hi! link javascriptLogicSymbols RoseboxFg1
hi! link javascriptArrowFunc RoseboxYellow

hi! link javascriptDocParamName RoseboxFg4
hi! link javascriptDocTags RoseboxFg4
hi! link javascriptDocNotation RoseboxFg4
hi! link javascriptDocParamType RoseboxFg4
hi! link javascriptDocNamedParamType RoseboxFg4

hi! link javascriptBrackets RoseboxFg1
hi! link javascriptDOMElemAttrs RoseboxFg1
hi! link javascriptDOMEventMethod RoseboxFg1
hi! link javascriptDOMNodeMethod RoseboxFg1
hi! link javascriptDOMStorageMethod RoseboxFg1
hi! link javascriptHeadersMethod RoseboxFg1

hi! link javascriptAsyncFuncKeyword RoseboxRed
hi! link javascriptAwaitFuncKeyword RoseboxRed

" }}}
" PanglossJS: {{{

hi! link jsClassKeyword RoseboxAqua
hi! link jsExtendsKeyword RoseboxAqua
hi! link jsExportDefault RoseboxAqua
hi! link jsTemplateBraces RoseboxAqua
hi! link jsGlobalNodeObjects RoseboxBlue
hi! link jsGlobalObjects RoseboxBlue
hi! link jsObjectKey RoseboxGreenBold
hi! link jsFunction RoseboxAqua
hi! link jsFuncCall RoseboxBlue
hi! link jsFuncParens RoseboxFg3
hi! link jsParens RoseboxFg3
hi! link jsNull RoseboxPurple
hi! link jsUndefined RoseboxPurple
hi! link jsClassDefinition RoseboxYellow
hi! link jsOperatorKeyword RoseboxRed

" }}}
" TypeScript: {{{

hi! link typescriptReserved RoseboxAqua
hi! link typescriptLabel RoseboxAqua
hi! link typescriptFuncKeyword RoseboxAqua
hi! link typescriptIdentifier RoseboxOrange
hi! link typescriptBraces RoseboxFg1
hi! link typescriptEndColons RoseboxFg1
hi! link typescriptDOMObjects RoseboxFg1
hi! link typescriptAjaxMethods RoseboxFg1
hi! link typescriptLogicSymbols RoseboxFg1
hi! link typescriptDocSeeTag Comment
hi! link typescriptDocParam Comment
hi! link typescriptDocTags vimCommentTitle
hi! link typescriptGlobalObjects RoseboxFg1
hi! link typescriptParens RoseboxFg3
hi! link typescriptOpSymbols RoseboxFg3
hi! link typescriptHtmlElemProperties RoseboxFg1
hi! link typescriptNull RoseboxPurple
hi! link typescriptInterpolationDelimiter RoseboxAqua

" }}}
" JSX: maxmellon/vim-jsx-pretty: {{{

hi! link jsxTagName RoseboxAqua
hi! link jsxComponentName RoseboxGreen
hi! link jsxCloseString RoseboxFg4
hi! link jsxAttrib RoseboxYellow
hi! link jsxEqual RoseboxAqua

"}}}
" PureScript: {{{

hi! link purescriptModuleKeyword RoseboxAqua
hi! link purescriptModuleName RoseboxFg1
hi! link purescriptWhere RoseboxAqua
hi! link purescriptDelimiter RoseboxFg4
hi! link purescriptType RoseboxFg1
hi! link purescriptImportKeyword RoseboxAqua
hi! link purescriptHidingKeyword RoseboxAqua
hi! link purescriptAsKeyword RoseboxAqua
hi! link purescriptStructure RoseboxAqua
hi! link purescriptOperator RoseboxBlue

hi! link purescriptTypeVar RoseboxFg1
hi! link purescriptConstructor RoseboxFg1
hi! link purescriptFunction RoseboxFg1
hi! link purescriptConditional RoseboxOrange
hi! link purescriptBacktick RoseboxOrange

" }}}
" CoffeeScript: {{{

hi! link coffeeExtendedOp RoseboxFg3
hi! link coffeeSpecialOp RoseboxFg3
hi! link coffeeCurly RoseboxOrange
hi! link coffeeParen RoseboxFg3
hi! link coffeeBracket RoseboxOrange

" }}}
" Ruby: {{{

hi! link rubyStringDelimiter RoseboxGreen
hi! link rubyInterpolationDelimiter RoseboxAqua

" }}}
" ObjectiveC: {{{

hi! link objcTypeModifier RoseboxRed
hi! link objcDirective RoseboxBlue

" }}}
" Go: {{{

hi! link goDirective RoseboxAqua
hi! link goConstants RoseboxPurple
hi! link goDeclaration RoseboxRed
hi! link goDeclType RoseboxBlue
hi! link goBuiltins RoseboxOrange

" }}}
" Lua: {{{

hi! link luaIn RoseboxRed
hi! link luaFunction RoseboxAqua
hi! link luaTable RoseboxOrange

" }}}
" MoonScript: {{{

hi! link moonSpecialOp RoseboxFg3
hi! link moonExtendedOp RoseboxFg3
hi! link moonFunction RoseboxFg3
hi! link moonObject RoseboxYellow

" }}}
" Java: {{{

hi! link javaAnnotation RoseboxBlue
hi! link javaDocTags RoseboxAqua
hi! link javaCommentTitle vimCommentTitle
hi! link javaParen RoseboxFg3
hi! link javaParen1 RoseboxFg3
hi! link javaParen2 RoseboxFg3
hi! link javaParen3 RoseboxFg3
hi! link javaParen4 RoseboxFg3
hi! link javaParen5 RoseboxFg3
hi! link javaOperator RoseboxOrange

hi! link javaVarArg RoseboxGreen

" }}}
" Elixir: {{{

hi! link elixirDocString Comment

hi! link elixirStringDelimiter RoseboxGreen
hi! link elixirInterpolationDelimiter RoseboxAqua

hi! link elixirModuleDeclaration RoseboxYellow

" }}}
" Scala: {{{

" NB: scala vim syntax file is kinda horrible
hi! link scalaNameDefinition RoseboxFg1
hi! link scalaCaseFollowing RoseboxFg1
hi! link scalaCapitalWord RoseboxFg1
hi! link scalaTypeExtension RoseboxFg1

hi! link scalaKeyword RoseboxRed
hi! link scalaKeywordModifier RoseboxRed

hi! link scalaSpecial RoseboxAqua
hi! link scalaOperator RoseboxFg1

hi! link scalaTypeDeclaration RoseboxYellow
hi! link scalaTypeTypePostDeclaration RoseboxYellow

hi! link scalaInstanceDeclaration RoseboxFg1
hi! link scalaInterpolation RoseboxAqua

" }}}
" Markdown: {{{

call s:HL('markdownItalic', s:fg3, s:none, s:italic)
call s:HL('markdownBold', s:fg3, s:none, s:bold)
call s:HL('markdownBoldItalic', s:fg3, s:none, s:bold . s:italic)

hi! link markdownH1 RoseboxGreenBold
hi! link markdownH2 RoseboxGreenBold
hi! link markdownH3 RoseboxYellowBold
hi! link markdownH4 RoseboxYellowBold
hi! link markdownH5 RoseboxYellow
hi! link markdownH6 RoseboxYellow

hi! link markdownCode RoseboxAqua
hi! link markdownCodeBlock RoseboxAqua
hi! link markdownCodeDelimiter RoseboxAqua

hi! link markdownBlockquote RoseboxGray
hi! link markdownListMarker RoseboxGray
hi! link markdownOrderedListMarker RoseboxGray
hi! link markdownRule RoseboxGray
hi! link markdownHeadingRule RoseboxGray

hi! link markdownUrlDelimiter RoseboxFg3
hi! link markdownLinkDelimiter RoseboxFg3
hi! link markdownLinkTextDelimiter RoseboxFg3

hi! link markdownHeadingDelimiter RoseboxOrange
hi! link markdownUrl RoseboxPurple
hi! link markdownUrlTitleDelimiter RoseboxGreen

call s:HL('markdownLinkText', s:gray, s:none, s:underline)
hi! link markdownIdDeclaration markdownLinkText

" }}}
" Haskell: {{{

hi! link haskellType RoseboxBlue
hi! link haskellIdentifier RoseboxAqua
hi! link haskellSeparator RoseboxFg4
hi! link haskellDelimiter RoseboxOrange
hi! link haskellOperators RoseboxPurple

hi! link haskellBacktick RoseboxOrange
hi! link haskellStatement RoseboxPurple
hi! link haskellConditional RoseboxPurple

hi! link haskellLet RoseboxRed
hi! link haskellDefault RoseboxRed
hi! link haskellWhere RoseboxRed
hi! link haskellBottom RoseboxRedBold
hi! link haskellImportKeywords RoseboxPurpleBold
hi! link haskellDeclKeyword RoseboxOrange
hi! link haskellDecl RoseboxOrange
hi! link haskellDeriving RoseboxPurple
hi! link haskellAssocType RoseboxAqua

hi! link haskellNumber RoseboxAqua
hi! link haskellPragma RoseboxRedBold

hi! link haskellTH RoseboxAquaBold
hi! link haskellForeignKeywords RoseboxGreen
hi! link haskellKeyword RoseboxRed
hi! link haskellFloat RoseboxAqua
hi! link haskellInfix RoseboxPurple
hi! link haskellQuote RoseboxGreenBold
hi! link haskellShebang RoseboxYellowBold
hi! link haskellLiquid RoseboxPurpleBold
hi! link haskellQuasiQuoted RoseboxBlueBold
hi! link haskellRecursiveDo RoseboxPurple
hi! link haskellQuotedType RoseboxRed
hi! link haskellPreProc RoseboxFg4
hi! link haskellTypeRoles RoseboxRedBold
hi! link haskellTypeForall RoseboxRed
hi! link haskellPatternKeyword RoseboxBlue

" }}}
" Json: {{{

hi! link jsonKeyword RoseboxGreen
hi! link jsonQuote RoseboxGreen
hi! link jsonBraces RoseboxFg1
hi! link jsonString RoseboxFg1

" }}}
" Mail: {{{

" Override some defaults defined by mail.vim
" mail quoted text
hi! link mailQuoted1 RoseBoxAqua
hi! link mailQuoted2 RoseBoxPurple
hi! link mailQuoted3 RoseBoxYellow
hi! link mailQuoted4 RoseBoxGreen
hi! link mailQuoted5 RoseBoxRed
hi! link mailQuoted6 RoseBoxOrange

hi! link mailSignature Comment

" }}}
" C#: {{{

hi! link csBraces RoseboxFg1
hi! link csEndColon RoseboxFg1
hi! link csLogicSymbols RoseboxFg1
hi! link csParens RoseboxFg3
hi! link csOpSymbols RoseboxFg3
hi! link csInterpolationDelimiter RoseboxFg3
hi! link csInterpolationAlignDel RoseboxAquaBold
hi! link csInterpolationFormat RoseboxAqua
hi! link csInterpolationFormatDel RoseboxAquaBold

" }}}
" Rust: {{{

hi! link rustSigil RoseboxOrange
hi! link rustEscape RoseboxAqua
hi! link rustStringContinuation RoseboxAqua
hi! link rustEnum RoseboxAqua
hi! link rustStructure RoseboxAqua
hi! link rustModPathSep RoseboxFg2
hi! link rustCommentLineDoc Comment
hi! link rustDefault RoseboxAqua

" }}}
" Ocaml: {{{

hi! link ocamlOperator RoseboxFg1
hi! link ocamlKeyChar RoseboxOrange
hi! link ocamlArrow RoseboxOrange
hi! link ocamlInfixOpKeyword RoseboxRed
hi! link ocamlConstructor RoseboxOrange

" }}}


" Functions -------------------------------------------------------------------
" Search Highlighting Cursor {{{

function! RoseboxHlsShowCursor()
  call s:HL('Cursor', s:bg0, s:hls_cursor)
endfunction

function! RoseboxHlsHideCursor()
  call s:HL('Cursor', s:none, s:none, s:inverse)
endfunction

" }}}

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker:
