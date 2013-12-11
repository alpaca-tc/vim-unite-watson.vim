# README

vim-unite-watson.vim is the [unite](https://github.com/Shougo/unite.vim) source for [watson](https://github.com/nhmood/watson-ruby).

![image_1](https://f.cloud.github.com/assets/1688137/1641452/32061070-5855-11e3-98e1-c02c4973611f.gif)

## Install

*.vimrc*

```vim
" Using Bundle
Bundle 'alpaca-tc/vim-unite-watson.vim'
Bundle 'Shougo/unite.vim'

" Using NeoBundle
NeoBundleLazy 'alpaca-tc/vim-unite-watson.vim', {
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

- `:Unite watson`
- `:Unite watson/dirty`
- `:Unite watson/clean`
