" -----------------------------------------------------------------------------
" File: rosebox.vim
" Description: Retro groove color scheme for Vim
" Author: morhetz <morhetz@gmail.com>
" Source: https://github.com/rosebox-community/rosebox
" -----------------------------------------------------------------------------

function! rosebox#invert_signs_toggle()
  if g:rosebox_invert_signs == 0
    let g:rosebox_invert_signs=1
  else
    let g:rosebox_invert_signs=0
  endif

  colorscheme rosebox
endfunction

" Search Highlighting {{{

function! rosebox#hls_show()
  set hlsearch
  call RoseboxHlsShowCursor()
endfunction

function! rosebox#hls_hide()
  set nohlsearch
  call RoseboxHlsHideCursor()
endfunction

function! rosebox#hls_toggle()
  if &hlsearch
    call rosebox#hls_hide()
  else
    call rosebox#hls_show()
  endif
endfunction

" }}}

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker:
