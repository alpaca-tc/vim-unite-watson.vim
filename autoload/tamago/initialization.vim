function! tamago#initialization#is_available() "{{{
  return executable('tamago') || s:executable_tamago_with_tamago()
endfunction"}}}

function! s:executable_tamago_with_tamago() "{{{
  " [todo] - `bundle exec tamago`に対応する
  return 1
endfunction"}}}
