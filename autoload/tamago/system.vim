function! tamago#system#execute_from_project_root(path, option, ...) "{{{
  let current_path = getcwd()
  let is_shell_command = !empty(a:000)

  try
    let project_root = unite#util#path2project_directory(a:path)
    lcd `=project_root`

    let function = is_shell_command ? 'run_shell' : 'run_system'
    let result = tamago#system#{function}(a:option)
  finally
    lcd `=current_path`
  endtry

  return result
endfunction"}}}

function! tamago#system#run_system(option) "{{{
  let command = 'tamago ' . a:option
  call unite#print_message(command)

  return system(command)
endfunction"}}}

function! tamago#system#run_shell(option) "{{{
  let command = 'tamago ' . a:option
  call unite#print_message(command)
  execute '!' . command

  return ''
endfunction"}}}
