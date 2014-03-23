function! unite#sources#tamago#default#define() "{{{
  return [s:tamago, s:tamago_clean, s:tamago_dirty]
endfunction"}}}

let s:tamago = {
      \ 'name' : 'tamago',
      \ 'hooks' : {},
      \ 'syntax' : 'uniteSource__WatsonDefault',
      \ 'is_multiline' : 1,
      \ 'description' : 'candidates from tamago',
      \ 'default_kind' : 'jump_list',
      \ }
function! s:tamago.hooks.on_syntax(args, context) "{{{
  " syntax case ignore
  syntax region uniteSource__WatsonLine start=' ' end='$'
  " -- Second line
  " \ start='  |     \w\+ - ' end='$'
  " syntax region uniteSource__WatsonSecondLine
  "       \ start='\zs  |     \w\+ - ' end='$'
  "       \ containedin=uniteSource__WatsonDefault
  " syntax match uniteSource__WatsonTag /^\s\+|\s\+\w - /
  "       \ containedin=uniteSource__WatsonSecondLine

  " -- First line
  " g.u
  " [o] Rakefile
  " [x] review (tamago.gemspec:2)
  syntax region uniteSource__WatsonFirstLine
        \ start='\s*\[\(o\|x\)]' end='$'
        \ containedin=uniteSource__WatsonLine
  syntax match uniteSource__WatsonBracket /\[\(o\|x\)]/
        \ contained containedin=uniteSource__WatsonFirstLine
  syntax match uniteSource__WatsonResultGood /o/ contained containedin=uniteSource__WatsonBracket
  syntax match uniteSource__WatsonResultBad /x/ contained containedin=uniteSource__WatsonBracket
  syntax match uniteSource__WatsonTag / \(\w\+\) (/ms=s+1,me=e-2
        \ containedin=uniteSource__WatsonFirstLine

  " syntax match uniteSource__WatsonTagName
  "       \ "\<\%(fix\|todo\|review\)\>[?!]\@!"
  "       \ containedin=uniteSource__WatsonTag

  " filepath
  syntax match uniteSource__WatsonPath /([^)]\+)/ contained
        \ containedin=uniteSource__WatsonFirstLine

  highlight WatsonBracket cterm=NONE gui=bold cterm=bold
  highlight WatsonBad guifg=#cd5c5c guibg=NONE guisp=NONE gui=NONE ctermfg=167 ctermbg=NONE cterm=NONE
  highlight WatsonGood term=bold ctermfg=114 gui=italic guifg=#7ccd7c

  " [o], [x]
  highlight default link uniteSource__WatsonBracket WatsonBracket
  highlight default link uniteSource__WatsonResultBad WatsonBad
  highlight default link uniteSource__WatsonResultGood WatsonGood

  " filepath
  highlight default link uniteSource__WatsonPath Directory

  " highlight default link uniteSource__WatsonFirstLine Error
  " highlight default link uniteSource__WatsonTagName Type
  highlight default link uniteSource__WatsonTag Type
endfunction"}}}
function! s:tamago.gather_candidates(args, context) "{{{
  let result = unite#sources#tamago#utils#get_results(expand('%:p'), '')
  call map(result, 's:format_candidate(v:val)')

  return result
endfunction"}}}

let s:tamago_clean = copy(s:tamago)
let s:tamago_clean.name = 'tamago/clean'
function! s:tamago_clean.gather_candidates(args, context) "{{{
  let result = unite#sources#tamago#utils#get_results(expand('%:p'), '')
  call filter(result, '!v:val["action__has_issue"]')
  call map(result, 's:format_candidate(v:val)')

  return result
endfunction"}}}

let s:tamago_dirty = copy(s:tamago)
let s:tamago_dirty.name = 'tamago/dirty'
function! s:tamago_dirty.gather_candidates(args, context) "{{{
  let result = unite#sources#tamago#utils#get_results(expand('%:p'), '')
  call filter(result, 'v:val["action__has_issue"]')
  call map(result, 's:format_candidate(v:val)')

  return result
endfunction"}}}

function! s:format_candidate(candidate) "{{{
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
