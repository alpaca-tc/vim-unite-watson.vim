function! tamago#execute(options) "{{{
  let path = expand('%:p')
  call tamago#system#execute_from_project_root(path, a:options, 1)
endfunction"}}}

function! tamago#complete(arg_lead, cmd_line, cursor_pos) "{{{
  let args = split(a:cmd_line, '\s', 1)
  return tamago#completion#do_complete(args)
endfunction"}}}
