"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Name:             gramadoir.vim
" Description:      Vim interface to An Gramadóir Irish grammar checker
" Author:           Kevin Patrick Scannell <scannell@slu.edu>
" Url:              http://borel.slu.edu/gramadoir/
"
" Licence:          This program is free software; you can redistribute it
"                   and/or modify it under the terms of the GNU General Public
"                   License.  See http://www.gnu.org/copyleft/gpl.txt
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if exists("loaded_gramadoir") || &compatible
   finish
endif
let loaded_gramadoir = 1
let s:active_file = 0
let s:cpo_save = &cpo
set cpo&vim

function s:Check()
  echo "An Gramadóir: fan go fóill..."
  let l:filename=expand("%")
  if !strlen(l:filename)
    let l:filename=tempname()
    silent execute "w!".l:filename
  endif
  let errorfile = tempname()
  let l:dummy=system('cat '. escape(l:filename,' \')." | gr --html | sed 's/<br>//g; s/ class=gramadoir//g' > ".escape(errorfile,' \'))
  silent exe 'split ' . errorfile
  execute "normal \<C-W>b"
  execute "normal \<C-W>K"
  execute "normal \<C-W>b"
  execute "normal 6\<C-W>_"
  execute "normal 1G"
  execute "normal \<C-W>t"
  execute "normal 1G"
  let s:active_file = 1
endfunction

function s:NextError()
  if s:active_file == 0
    call s:Check()
  endif
  syntax clear
  execute "normal \<C-W>b"
  syntax clear
  call search("<b>[^<]*<.b>")
  let l:currline=getline(".")
  let l:position=col(".")
  let l:linenumber=matchstr(l:currline, "^[1-9][0-9]*")
  let l:boldplustail=strpart(l:currline, l:position-1, strlen(l:currline)-l:position)
  let l:bolderror=matchstr(l:boldplustail, "<b>[^<]*<.b>")
  let l:errorwords=strpart(l:bolderror, 3, strlen(l:bolderror)-7)
  execute "normal jk0".l:position."l"
  execute "normal ll"
  execute "syntax match grError /".l:errorwords."/"
  execute "normal \<C-W>t"
  execute "normal ".l:linenumber."G"
  call search(l:errorwords)
  execute "syntax match grError /".l:errorwords."/"
  highlight grError cterm=bold ctermfg=Red guifg=Red
endfunction

function s:QuitGr()
  let s:active_file = 0
  execute "normal \<C-W>b"
  q!
endfunction

if !hasmapto('<Plug>Gr')
  map <unique> <Leader>g <Plug>Gr
endif
if !hasmapto('<Plug>Amach')
  map <unique> <Leader>a <Plug>Amach
endif

noremap <unique> <script> <Plug>Gr <SID>NextError
noremap <silent> <SID>NextError :call <SID>NextError()<CR>
noremap <unique> <script> <Plug>Amach <SID>QuitGr
noremap <silent> <SID>QuitGr :call <SID>QuitGr()<CR>

let &cpo = s:cpo_save
finish
