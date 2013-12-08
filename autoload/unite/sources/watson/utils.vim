let s:JSON = vital#of('vital').import('Web.JSON')

function! unite#sources#watson#utils#get_results(path, options) "{{{
  let current_path = getcwd()

  try
    let project_dir = unite#util#path2project_directory(a:path)
    lcd `=project_dir`
    call system('watson --format unite ' . a:options)
    let result = s:read_json_from(project_dir . '/.watsonresults')
    call map(result, 's:format_json(v:val)')
  catch /.*/
    let result = []
  finally
    lcd `=current_path`
  endtry

  return result
endfunction"}}}

function! s:format_json(candidate) "{{{
  let c = a:candidate

  if c['action__has_issue'] == 0
    let c.word = '[o] ' . c['action__relative_path']
    let c.is_multiline = 0
  else
    let line = get(c, 'action__line', '')
    let file_path = '(' . c['action__relative_path'] . ':' . line . ')'

    let tag       = get(c, 'action__tag', '')
    let title     = get(c, 'action__title', '')

    let title_formatted = '  - ' . title
    let word = join(['[x]', tag, file_path], ' ') . "\n" . title_formatted
    let c.word = word
  endif

  return c
endfunction"}}}

function! s:read_json_from(path) "{{{
  let file = readfile(expand(a:path))[0]
  return s:JSON.decode(file)
endfunction"}}}
