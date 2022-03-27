set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set smartindent
set exrc
set guicursor=
set relativenumber
set nu
set nohlsearch
set hidden
set noerrorbells
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set scrolloff=8
set colorcolumn=80
set signcolumn=yes

call plug#begin('~/.vim/plugged')
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'gruvbox-community/gruvbox'

call plug#end()

colorscheme gruvbox

let mapleader = " "
nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>

nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

fun! TrimWhitespace()
  let l:save = winsaveview()
  keeppatterns %s/\s\s+$//e
  call winrestview(l:save)
endfun

augroup FELL
  autocmd!
  autocmd BufWritePre * :call TrimWhitespace()
augroup END

