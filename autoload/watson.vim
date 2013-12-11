function! watson#execute(options) "{{{
  let path = expand('%:p')
  call watson#system#execute_from_project_root(path, a:options, 1)
endfunction"}}}

function! watson#complete(arg_lead, cmd_line, cursor_pos) "{{{
  let args = split(a:cmd_line, '\s', 1)
  return watson#completion#do_complete(args)
endfunction"}}}
