let s:JSON = vital#of('vital').import('Web.JSON')

function! unite#sources#watson#utils#get_results(path, options) "{{{
  let current_path = getcwd()

  try
    let project_dir = unite#util#path2project_directory(a:path)
    lcd `=project_dir`
    let command = 'watson --format unite ' . a:options
    call system(command)
    let result = s:read_json_from(project_dir . '/.watsonresults')
  catch /.*/
    let result = []
  finally
    lcd `=current_path`
  endtry

  return result
endfunction"}}}

function! s:read_json_from(path) "{{{
  let file = readfile(expand(a:path))[0]
  return s:JSON.decode(file)
endfunction"}}}
