# README

vim-unite-watson.vim is the [unite](https://github.com/Shougo/unite.vim) source for [watson](https://github.com/nhmood/watson-ruby).

**:Unite watson**

![:Unite watson](https://f.cloud.github.com/assets/1688137/1726147/ac9b52fc-628a-11e3-8117-ef4824444729.gif)

**:Watson**

![:Watson](https://f.cloud.github.com/assets/1688137/1726081/92118d1c-6289-11e3-82ff-bea1f1b91437.png)

## Install

*.vimrc*

```vim
" Using Bundle
Bundle 'Shougo/unite.vim'
Bundle 'alpaca-tc/vim-unite-watson.vim'

" Using NeoBundle
NeoBundleLazy 'alpaca-tc/vim-unite-watson.vim', {
      \ 'commands' : 'Watson',
      \ 'depends' : 'Shougo/unite.vim',
      \ 'autoload' : {
      \   'unite_sources' : ['watson', 'watson/dirty', 'watson/clean', 'watson/current_file'],
      \ }}
```

*Install watson*

```sh
git clone https://github.com/nhmood/watson-ruby/
cd watson-ruby
rake install
```

## Usage

- `:Watson [{options}]`
- `:Unite watson`
- `:Unite watson/dirty`
- `:Unite watson/clean`
- `:Unite watson/current_file`

## Example

```vim
filetype plugin indent off

let s:bundle_dir = expand('~/.bundle')
if has('vim_starting') && !isdirectory(s:bundle_dir.'/neobundle.vim')
  call system('git clone https://github.com/Shougo/neobundle.vim.git '. s:bundle_dir . '/neobundle.vim')
endif

if has('vim_starting')
  execute 'set runtimepath+=' . s:bundle_dir . '/neobundle.vim'
  call neobundle#rc(s:bundle_dir)
endif

NeoBundleLazy 'alpaca-tc/vim-unite-watson.vim', {
      \ 'commands' : 'Watson',
      \ 'depends' : 'Shougo/unite.vim',
      \ 'autoload' : {
      \   'unite_sources' : ['watson', 'watson/dirty', 'watson/clean', 'watson/current_file'],
      \ }}

if has('vim_starting') && neobundle#exists_not_installed_bundles()
  execute 'NeoBundleInstall' join(neobundle#get_not_installed_bundle_names(), ' ')
endif

filetype plugin indent on

nnoremap <silent><C-J>d :Unite watson/dirty<CR>
nnoremap <silent><C-J>c :Unite watson/current_file<CR>
```
