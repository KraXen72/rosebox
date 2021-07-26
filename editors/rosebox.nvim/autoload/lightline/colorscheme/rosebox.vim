" -----------------------------------------------------------------------------
" File: rosebox.vim
" Description: Rosebox colorscheme for Lightline (itchyny/lightline.vim)
" Author: gmoe <me@griffinmoe.com>
" Source: https://github.com/rosebox-community/rosebox
" -----------------------------------------------------------------------------

function! s:getRoseColor(group)
  let guiColor = synIDattr(hlID(a:group), "fg", "gui")
  let termColor = synIDattr(hlID(a:group), "fg", "cterm")
  return [ guiColor, termColor ]
endfunction

if exists('g:lightline')

  let s:bg0  = s:getRoseColor('RoseboxBg0')
  let s:bg1  = s:getRoseColor('RoseboxBg1')
  let s:bg2  = s:getRoseColor('RoseboxBg2')
  let s:bg4  = s:getRoseColor('RoseboxBg4')
  let s:fg1  = s:getRoseColor('RoseboxFg1')
  let s:fg4  = s:getRoseColor('RoseboxFg4')

  let s:yellow = s:getRoseColor('RoseboxYellow')
  let s:blue   = s:getRoseColor('RoseboxBlue')
  let s:aqua   = s:getRoseColor('RoseboxAqua')
  let s:orange = s:getRoseColor('RoseboxOrange')
  let s:red = s:getRoseColor('RoseboxRed')
  let s:green = s:getRoseColor('RoseboxGreen')

  let s:p = {'normal':{}, 'inactive':{}, 'insert':{}, 'replace':{}, 'visual':{}, 'tabline':{}, 'terminal':{}}
  let s:p.normal.left = [ [ s:bg0, s:fg4, 'bold' ], [ s:fg4, s:bg2 ] ]
  let s:p.normal.right = [ [ s:bg0, s:fg4 ], [ s:fg4, s:bg2 ] ]
  let s:p.normal.middle = [ [ s:fg4, s:bg1 ] ]
  let s:p.inactive.right = [ [ s:bg4, s:bg1 ], [ s:bg4, s:bg1 ] ]
  let s:p.inactive.left =  [ [ s:bg4, s:bg1 ], [ s:bg4, s:bg1 ] ]
  let s:p.inactive.middle = [ [ s:bg4, s:bg1 ] ]
  let s:p.insert.left = [ [ s:bg0, s:blue, 'bold' ], [ s:fg1, s:bg2 ] ]
  let s:p.insert.right = [ [ s:bg0, s:blue ], [ s:fg1, s:bg2 ] ]
  let s:p.insert.middle = [ [ s:fg4, s:bg1 ] ]
  let s:p.terminal.left = [ [ s:bg0, s:green, 'bold' ], [ s:fg1, s:bg2 ] ]
  let s:p.terminal.right = [ [ s:bg0, s:green ], [ s:fg1, s:bg2 ] ]
  let s:p.terminal.middle = [ [ s:fg4, s:bg1 ] ]
  let s:p.replace.left = [ [ s:bg0, s:aqua, 'bold' ], [ s:fg1, s:bg2 ] ]
  let s:p.replace.right = [ [ s:bg0, s:aqua ], [ s:fg1, s:bg2 ] ]
  let s:p.replace.middle = [ [ s:fg4, s:bg1 ] ]
  let s:p.visual.left = [ [ s:bg0, s:orange, 'bold' ], [ s:bg0, s:bg4 ] ]
  let s:p.visual.right = [ [ s:bg0, s:orange ], [ s:bg0, s:bg4 ] ]
  let s:p.visual.middle = [ [ s:fg4, s:bg1 ] ]
  let s:p.tabline.left = [ [ s:fg4, s:bg2 ] ]
  let s:p.tabline.tabsel = [ [ s:bg0, s:fg4 ] ]
  let s:p.tabline.middle = [ [ s:bg0, s:bg4 ] ]
  let s:p.tabline.right = [ [ s:bg0, s:orange ] ]
  let s:p.normal.error = [ [ s:bg0, s:red ] ]
  let s:p.normal.warning = [ [ s:bg0, s:yellow ] ]

  let g:lightline#colorscheme#rosebox#palette = lightline#colorscheme#flatten(s:p)
endif
