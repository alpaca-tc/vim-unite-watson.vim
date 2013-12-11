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

function! watson#completion#do_complete(args) "{{{
  let args = a:args

  if empty(args)
    return s:default_arguments
  else
    let last = args[-1]
    if count(s:skip_arguments, last)
      return s:default_arguments
    elseif last =~ '^-'
      return filter(copy(s:default_arguments), "v:val =~ '^' . last")
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

function! s:dispatch_completion(last_option, last) "{{{
  let function = ''

  if a:last_option =~ '\v(-c|--context-depth)'
    let function = 'context_depth'
  elseif a:last_option =~ '\v(-d|--dirs)'
    let function = 'dirs'
  elseif a:last_option =~ '\v(-f|--files)'
    let function = 'files'
  elseif a:last_option =~ '\v(--format)'
    let function = 'format'
  elseif a:last_option =~ '\v(-h|--help)'
    let function = 'help'
  elseif a:last_option =~ '\v(-i|--ignore)'
    let function = 'ignore'
  elseif a:last_option =~ '\v(-p|--parse-depth)'
    let function = 'parse_depth'
  elseif a:last_option =~ '\v(-r|--remote)'
    let function = 'remote'
  elseif a:last_option =~ '\v(-s|--show)'
    let function = 'show'
  elseif a:last_option =~ '\v(-t|--tags)'
    let function = 'tags'
  elseif a:last_option =~ '\v(-u|--update)'
    let function = 'update'
  else
    return []
  endif

  return watson#completion#{function}(a:last)
endfunction"}}}

function! s:last_option(args) "{{{
  let args = copy(a:args)
  call filter(args, 'v:val =~ "^-"')

  return empty(args) ? '' : args[-1]
endfunction"}}}

" Completions
function! watson#completion#context_depth(arg) "{{{
  return []
endfunction"}}}

function! watson#completion#dirs(arg) "{{{
  return []
endfunction"}}}

function! watson#completion#files(arg) "{{{
  return []
endfunction"}}}

function! watson#completion#format(arg) "{{{
  return []
endfunction"}}}

function! watson#completion#help(arg) "{{{
  return []
endfunction"}}}

function! watson#completion#ignore(arg) "{{{
  return []
endfunction"}}}

function! watson#completion#parse_depth(arg) "{{{
  return []
endfunction"}}}

function! watson#completion#remote(arg) "{{{
  return []
endfunction"}}}

function! watson#completion#show(arg) "{{{
  return []
endfunction"}}}

function! watson#completion#tags(arg) "{{{
  return []
endfunction"}}}

function! watson#completion#update(arg) "{{{
  return []
endfunction"}}}
