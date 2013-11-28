function! unite#sources#watson#default#define() "{{{
  return s:source
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
  syntax region uniteSource__WatsonLine
        \ start=' ' end='$'
        \ containedin=uniteSource__WatsonDefault
  " -- Second line
        " \ start='  |     \w\+ - ' end='$'
  syntax region uniteSource__WatsonSecondLine
        \ start='\zs  |     \w\+ - ' end='$'
        \ containedin=uniteSource__WatsonDefault
  syntax match uniteSource__WatsonTag /\zs\w\+ - \ze/me=e-3
        \ containedin=uniteSource__WatsonSecondLine
  syntax match uniteSource__WatsonTagName
        \ "\<\%(fix\|todo\|review\)\>[?!]\@!"
        \ containedin=uniteSource__WatsonTag
  " syntax match uniteSource__WatsonTag /^\s\+|\s\+\w - /
  "       \ containedin=uniteSource__WatsonSecondLine

  " -- First line
  " [x], [o]
  syntax region uniteSource__WatsonFirstLine
        \ start='\zs\s\++\?\s*\[\(o\|x\)]' end='\ze'
        \ containedin=uniteSource__WatsonDefault
  syntax match uniteSource__WatsonBracket /\[\(o\|x\)]/
        \ contained containedin=uniteSource__WatsonFirstLine
  syntax match uniteSource__WatsonResultGood /o/ contained containedin=uniteSource__WatsonBracket
  syntax match uniteSource__WatsonResultBad /x/ contained containedin=uniteSource__WatsonBracket

  " filepath
  syntax match uniteSource__WatsonPath /\S\+\s*$/ contained
        \ containedin=uniteSource__WatsonFirstLine
  syntax match uniteSource__WatsonDirectory /.*\// contained
        \ containedin=uniteSource__WatsonPath
  syntax match uniteSource__WatsonSeparator /:/ contained
        \ containedin=uniteSource__WatsonPath



  highlight WatsonBracket cterm=NONE gui=bold cterm=bold
  highlight WatsonBad guifg=#cd5c5c guibg=NONE guisp=NONE gui=NONE ctermfg=167 ctermbg=NONE cterm=NONE
  highlight WatsonGood term=bold ctermfg=114 gui=italic guifg=#7ccd7c

  " [o], [x]
  highlight default link uniteSource__WatsonBracket WatsonBracket
  highlight default link uniteSource__WatsonResultBad WatsonBad
  highlight default link uniteSource__WatsonResultGood WatsonGood

  " filepath
  highlight default link uniteSource__WatsonDirectory Directory
  highlight default link uniteSource__WatsonSeparator Directory

  " highlight default link uniteSource__WatsonFirstLine Error
  highlight default link uniteSource__WatsonTagName Type
endfunction"}}}

function! s:source.gather_candidates(args, context) "{{{
  return unite#sources#watson#utils#get_results(expand('%:p'), '')
endfunction"}}}
