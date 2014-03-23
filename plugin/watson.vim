if exists('g:loaded_tamago') || !tamago#initialization#is_available()
  finish
endif
let g:loaded_tamago = 1

let s:save_cpo = &cpo
set cpo&vim

command! -nargs=* -complete=customlist,tamago#complete Tamago call tamago#execute(<q-args>)

let &cpo = s:save_cpo
unlet s:save_cpo
