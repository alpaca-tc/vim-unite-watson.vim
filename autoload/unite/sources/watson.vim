function! unite#sources#watson#define()
  if watson#initialization#is_available()
    return unite#sources#watson#default#define() +
          \ unite#sources#watson#current_file#define()
  else
    return []
  endif
endfunction
