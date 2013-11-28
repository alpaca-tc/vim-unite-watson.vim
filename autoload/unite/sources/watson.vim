function! unite#sources#watson#define() "{{{
  if s:is_available()
    return [
          \ unite#sources#watson#default#define(),
          \ ]
  else
    return []
  endif
endfunction"}}}

function! s:is_available() "{{{
  return executable('watson')
endfunction"}}}
