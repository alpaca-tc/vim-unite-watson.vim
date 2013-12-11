function! watson#initialization#is_available() "{{{
  return executable('watson') || s:executable_watson_with_watson()
endfunction"}}}

function! s:executable_watson_with_watson() "{{{
  " [todo] - `bundle exec watson`に対応する
  return 1
endfunction"}}}
