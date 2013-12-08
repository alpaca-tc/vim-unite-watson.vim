function! unite#sources#watson#default#define() "{{{
  return [s:source, s:source_clean, s:source_dirty]
endfunction"}}}

let s:source = {
      \ 'name' : 'watson',
      \ 'hooks' : {},
      \ 'syntax' : 'uniteSource__WatsonDefault',
      \ 'is_multiline' : 1,
      \ 'description' : 'candidates from watson',
      \ 'default_kind' : 'jump_list',
      \ }

function! s:source.hooks.on_syntax(args, context) "{{{
  syntax case ignore
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
  " [x] review (watson.gemspec:2)
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
function! s:source.gather_candidates(args, context) "{{{
  return unite#sources#watson#utils#get_results(expand('%:p'), '')
endfunction"}}}

let s:source_clean = copy(s:source)
let s:source_clean.name = 'watson/clean'
function! s:source_clean.gather_candidates(args, context) "{{{
  let result = unite#sources#watson#utils#get_results(expand('%:p'), '')
  call filter(result, '!v:val["action__has_issue"]')
  return result
endfunction"}}}

let s:source_dirty = copy(s:source)
let s:source_dirty.name = 'watson/dirty'
function! s:source_dirty.gather_candidates(args, context) "{{{
  let result = unite#sources#watson#utils#get_results(expand('%:p'), '')
  call filter(result, 'v:val["action__has_issue"]')
  return result
endfunction"}}}
