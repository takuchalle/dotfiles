" init autocmd
autocmd!
" set script encoding
scriptencoding utf-8
" stop loading config if it's on tiny or small
if !1 | finish | endif

" disable backup
set nobackup
" disable swapfile
set noswapfile
" auto reload
set autoread
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
" disable beep
set belloff=all
" keymap on command buffer
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
" increment search
set incsearch

set laststatus=2

syntax enable

call plug#begin('~/.vim/plugged')
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'mattn/vim-sonictemplate'
Plug 'jiangmiao/auto-pairs'
Plug 'itchyny/lightline.vim'
call plug#end()

let g:sonictemplate_vim_template_dir = [ '~/.dotfiles/sonictemplate' ]

nnoremap <C-]> :<C-u>LspDefinition<CR>

nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

let g:lsp_diagnostics_echo_cursor = 1
