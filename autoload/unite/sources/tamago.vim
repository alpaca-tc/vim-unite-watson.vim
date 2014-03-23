function! unite#sources#tamago#define()
  if tamago#initialization#is_available()
    return unite#sources#tamago#default#define() +
          \ unite#sources#tamago#current_file#define()
  else
    return []
  endif
endfunction
