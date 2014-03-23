# README

vim-unite-tamago.vim is the [unite](https://github.com/Shougo/unite.vim) source for [tamago](https://github.com/nhmood/tamago-ruby).

**:Unite tamago**

![:Unite tamago](https://f.cloud.github.com/assets/1688137/1726147/ac9b52fc-628a-11e3-8117-ef4824444729.gif)

**:Watson**

![:Watson](https://f.cloud.github.com/assets/1688137/1726081/92118d1c-6289-11e3-82ff-bea1f1b91437.png)

## Install

*.vimrc*

```vim
" Using Bundle
Bundle 'Shougo/unite.vim'
Bundle 'alpaca-tc/vim-unite-tamago.vim'

" Using NeoBundle
NeoBundleLazy 'alpaca-tc/vim-unite-tamago.vim', {
      \ 'commands' : 'Watson',
      \ 'depends' : 'Shougo/unite.vim',
      \ 'autoload' : {
      \   'unite_sources' : ['tamago', 'tamago/dirty', 'tamago/clean', 'tamago/current_file'],
      \ }}
```

*Install tamago*

```sh
git clone https://github.com/nhmood/tamago-ruby/
cd tamago-ruby
rake install
```

## Usage

- `:Watson [{options}]`
- `:Unite tamago`
- `:Unite tamago/dirty`
- `:Unite tamago/clean`
- `:Unite tamago/current_file`

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

NeoBundleLazy 'alpaca-tc/vim-unite-tamago.vim', {
      \ 'commands' : 'Watson',
      \ 'depends' : 'Shougo/unite.vim',
      \ 'autoload' : {
      \   'unite_sources' : ['tamago', 'tamago/dirty', 'tamago/clean', 'tamago/current_file'],
      \ }}

if has('vim_starting') && neobundle#exists_not_installed_bundles()
  execute 'NeoBundleInstall' join(neobundle#get_not_installed_bundle_names(), ' ')
endif

filetype plugin indent on

nnoremap <silent><C-J>d :Unite tamago/dirty<CR>
nnoremap <silent><C-J>c :Unite tamago/current_file<CR>
```
