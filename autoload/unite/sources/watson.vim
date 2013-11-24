function! unite#sources#watson#define() "{{{
  return s:is_available() ? [s:source_list] : []
endfunction"}}}

let s:source = {
      \ 'name' : 'watson',
      \ 'hooks' : {},
      \ 'syntax' : 'uniteSource__Action',
      \ 'is_multiline' : 1,
      \ 'description' : 'candidates from watson',
      \ 'default_kind' : 'jump_list',
      \ }

let s:source_list = copy(s:source)
let s:source_list.name = 'watson/list'
let s:source_list.is_multiline = 0

function! s:source_list.hooks.on_syntax(args, context) "{{{
  " syntax match uniteSource__ActionDescriptionLine /^.*$/ contained containedin=uniteSource__Action
  " syntax match uniteSource__ActionWatsonTag /\[review]/ contained containedin=uniteSource__ActionDescriptionLine
  " syntax match uniteSource__ActionWatsonTag /\[todo]/ contained containedin=uniteSource__ActionDescriptionLine
  " syntax match uniteSource__ActionWatsonTag /^./
  " highlight link uniteSource__ActionWatsonTag Type
endfunction"}}}

function! s:source_list.gather_candidates(args, context) "{{{
  return s:create_candidate()
endfunction"}}}

function! s:create_candidate() "{{{
  let json = [
        \ {
        \   'path' : 'lib/watson/version.rb',
        \   'line' : '36',
        \   'comment' : "Don't use DEBUG inside Remote class but pull from calling method's class?",
        \   'tag' : 'review',
        \ },
        \ {
        \   'path' : 'lib/watson/version.rb',
        \   'line' : '37',
        \   'comment' : "Not sure if this is the best/proper way to do things but it works...",
        \   'tag' : 'review',
        \ },
        \ {
        \   'path' : 'lib/watson/huga.rb',
        \   'line' : '37',
        \   'comment' : "Not sure if to fail with no method or default to GET?",
        \   'tag' : 'todo',
        \ },
        \ {
        \   'path' : 'lib/watson/github.rb',
        \   'line' : '13',
        \   'comment' : 'Combine into single statement (for performance or something?)',
        \   'tag' : 'todo',
        \ },
        \ {
        \   'path' : 'lib/watson/github.rb',
        \   'line' : '70',
        \   'comment' : 'Read and store rc FP inside initialize?',
        \   'tag' : 'todo',
        \ },
        \ {
        \   'path' : 'lib/watson/github.rb',
        \   'line' : '171',
        \   'comment' : 'Not sure if I should use the open/read/write or Fileutils.cp',
        \   'tag' : 'todo',
        \ },
        \ {
        \   'path' : 'lib/watson/github.rb',
        \   'line' : '178',
        \   'comment' : 'gsub uses (.?)+ to grab anything after lib (optional), better regex?',
        \   'tag' : 'todo',
        \ },
        \ {
        \   'path' : 'lib/watson/github.rb',
        \   'line' : '229',
        \   'comment' : 'Keep *.swp in there?',
        \   'tag' : 'todo'
        \ }
        \ ]
  return map(json, 's:line_to_candidate(v:val)')
endfunction"}}}

function! s:line_to_candidate(line) "{{{
  let path = a:line.path
  let linenr = a:line.line
  let max_path_len = 25
  let tag = '[' . a:line.tag . ']'
  let word = unite#util#truncate(
        \ printf('%s:%d  ', path, linenr), max_path_len) . ' ' . tag . ' ' . a:line.comment

  return {
        \ 'word' : word,
        \ 'action__path' : unite#util#substitute_path_separator(
        \     fnamemodify(unite#util#expand(path), ':p')),
        \ 'action__line' : linenr,
        \ }
endfunction"}}}

function! s:is_available() "{{{
  return executable('watson')
endfunction"}}}
