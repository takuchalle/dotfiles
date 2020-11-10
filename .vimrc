" init autocmd
autocmd!
" set script encoding
scriptencoding utf-8
" stop loading config if it's on tiny or small
if !1 | finish | endif

" command buffer history size
set history=200
" disable vi compatible mode
set nocompatible
" enable netrw
filetype plugin on
set number
set fileencodings=utf-8,sjis,euc-jp,latin
set encoding=utf-8
set title
set autoindent
set tabstop=4
set shiftwidth=4
set background=dark

" keymap on command buffer
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

syntax enable

call plug#begin('~/.vim/plugged')
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'mattn/vim-sonictemplate'
call plug#end()

let g:sonictemplate_vim_template_dir = [ '~/.dotfiles/sonictemplate' ]

nnoremap <C-]> :<C-u>LspDefinition<CR>

nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>
