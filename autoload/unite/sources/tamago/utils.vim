let s:JSON = vital#of('vim-unite-tamago.vim').import('Web.JSON')

function! unite#sources#tamago#utils#get_results(path, option) "{{{
  let output_file = '.tamago_unite_result'
  let command = '--file ' . output_file . ' --formatter unite ' . a:option
  call tamago#system#execute_from_project_root(a:path, command)

  let project_root = unite#util#path2project_directory(a:path)
  let result_file = project_root . '/' . output_file
  let result = s:read_json_from(result_file)

  return result
endfunction"}}}

function! s:read_json_from(path) "{{{
  let file = readfile(expand(a:path))[0]
  return s:JSON.decode(file)
endfunction"}}}
