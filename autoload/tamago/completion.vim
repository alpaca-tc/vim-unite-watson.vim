let s:default_arguments = [
      \ '-c', '--context-depth',
      \ '-d', '--dirs',
      \ '-f', '--files',
      \ '--format',
      \ '-h', '--help',
      \ '-i', '--ignore',
      \ '-p', '--parse-depth',
      \ '-r', '--remote',
      \ '-s', '--show',
      \ '-t', '--tags',
      \ '-u', '--update',
      \ ]
let s:skip_arguments = [
      \ '-h', '--help',
      \ '-v', '--version',
      \ ]

function! tamago#completion#do_complete(args) "{{{
  let args = a:args

  if empty(args)
    return s:default_arguments
  else
    let last = args[-1]
    if count(s:skip_arguments, last)
      return s:default_arguments
    elseif last =~ '^-'
      return s:filter(s:default_arguments, last)
    else
      let last_option = s:last_option(args)

      if empty(last_option)
        return s:default_arguments
      else
        return s:dispatch_completion(last_option, last)
      endif
    endif
  endif
endfunction"}}}

function! s:last_option(args) "{{{
  let args = copy(a:args)
  call filter(args, 'v:val =~ "^-"')

  return empty(args) ? '' : args[-1]
endfunction"}}}

function! s:dispatch_completion(last_option, last) "{{{
  let function = ''

  if a:last_option =~ '^\v(-d|--dirs)$'
    let function = 'dirs'
  elseif a:last_option =~ '^\v(-f|--files)$'
    let function = 'files'
  elseif a:last_option =~ '^\v(--format)$'
    let function = 'format'
  elseif a:last_option =~ '^\v(-i|--ignore)$'
    let function = 'ignore'
  elseif a:last_option =~ '^\v(-p|--parse-depth)$'
    let function = 'parse_depth'
  elseif a:last_option =~ '^\v(-r|--remote)$'
    let function = 'remote'
  elseif a:last_option =~ '^\v(-s|--show)$'
    let function = 'show'
  elseif a:last_option =~ '^\v(-t|--tags)$'
    let function = 'tags'
  elseif a:last_option =~ '^\v(-u|--update)$'
    let function = 'update'
  else
    " help, version, update, context-depth, parse-depth
    return []
  endif

  return tamago#completion#{function}(a:last)
endfunction"}}}

" Completions {{{
function! tamago#completion#dirs(arg) "{{{
  let file_and_dir = split(glob(a:arg . '*'), '\n')
  let candidates = filter(file_and_dir, 'isdirectory(v:val)')

  return sort(candidates)
endfunction"}}}

function! tamago#completion#files(arg) "{{{
  let candidates = filter(
        \ map(split(glob(a:arg . '*'), '\n'),
        \ "isdirectory(v:val) ? v:val.'/' : v:val"),
        \ 'stridx(v:val, a:arg) == 0')

  return sort(candidates)
endfunction"}}}

function! tamago#completion#format(arg) "{{{
  return s:filter(['default', 'json', 'silent', 'unite'], a:arg)
endfunction"}}}

function! tamago#completion#ignore(arg) "{{{
  return []
endfunction"}}}

function! tamago#completion#remote(arg) "{{{
  return s:filter(['github', 'bitbucket'], a:arg)
endfunction"}}}

function! tamago#completion#show(arg) "{{{
  return s:filter(['all', 'dirty', 'clean'], a:arg)
endfunction"}}}

function! tamago#completion#tags(arg) "{{{
  return s:filter(['todo', 'review', 'fix', a:arg], a:arg)
endfunction"}}}
"}}}

function! s:filter(candidates, val) "{{{
  return filter(copy(a:candidates), "v:val =~ '^' . a:val")
endfunction"}}}
