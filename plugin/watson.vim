if exists('g:loaded_watson') || !watson#initialization#is_available()
  finish
endif
let g:loaded_watson = 1

let s:save_cpo = &cpo
set cpo&vim

let &cpo = s:save_cpo
unlet s:save_cpo
