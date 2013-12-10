let s:source = {
      \ 'name' : 'watson/current_file',
      \ 'hooks' : {},
      \ 'syntax' : 'uniteSource__WatsonCurrentFile',
      \ 'is_multiline' : 1,
      \ 'description' : 'candidates from watson',
      \ 'default_kind' : 'jump_list',
      \ }

function! unite#sources#watson#current_file#define() "{{{
  return [s:source]
endfunction"}}}

function! s:source.hooks.on_syntax(args, context) "{{{
  syntax case ignore
  syntax region uniteSource__WatsonLine start='^' end='$'
  syntax match uniteSource__WatsonTagInformation /^\s*\d\+:\s\w\+\s/me=e-1
  syntax match uniteSource__WatsonTag /\a\+\ze/
        \ contained containedin=uniteSource__WatsonTagInformation
  syntax match uniteSource__WatsonLineNr /^\s*\d\+:/
        \ contained containedin=uniteSource__WatsonTagInformation
  highlight! default link uniteSource__WatsonLineNr LineNr
  highlight! default link uniteSource__WatsonTag Type
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

function! s:sort(a, b) "{{{
  if !has_key(a:a, 'action__line')
    return a:a
  elseif !has_key(a:b, 'action__line')
    return a:b
  else
    return a:a["action__line"] > a:b["action__line"]
  end
endfunction"}}}

function! s:format(candidate) "{{{
  let c = a:candidate
  let tag = c['action__tag']
  let title = c['action__title']
  let line = c['action__line']

  let len = len(line('$'))
  let line_reg = '%' . len . 'd'
  let pattern = line_reg . ": %-7s %s"

  let c.abbr = printf(pattern, line, tag, title)

  return c
endfunction"}}}
