let s:source = {
      \ 'name' : 'watson/current_file',
      \ 'hooks' : {},
      \ 'syntax' : 'uniteSource__WatsonDefault',
      \ 'is_multiline' : 1,
      \ 'description' : 'candidates from watson',
      \ 'default_kind' : 'jump_list',
      \ }

function! unite#sources#watson#current_file#define() "{{{
  return [s:source]
endfunction"}}}

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
  let absolute_path = expand('%:p')
  let option = '--files ' . absolute_path
  let candidates = unite#sources#watson#utils#get_results(absolute_path, option)

  if empty(candidates)
    let header = { 'word' : 'No issue found', 'is_dummy' : 1 }
    return header
  else
    return map(sort(candidates, 's:sort'), 's:format(v:val)')
  endif
endfunction"}}}

function! s:sort(a, b)
  if !has_key(a:a, 'action__line')
    return a:a
  elseif !has_key(a:b, 'action__line')
    return a:b
  else
    return a:a["action__line"] < a:b["action__line"]
  end
endfunction

function! s:format(candidate)
  let c = a:candidate
  " let tag = '[' . c['action__tag'] . ']'
  let title = c['action__title']
  " let line = c['action__line']

  " let c.word = 'L' . line . ' ' . tag . ' ' . title
  return c
endfunction
