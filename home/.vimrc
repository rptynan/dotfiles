""" General

"" First
set nocompatible

"" Appearance
syntax enable
set t_Co=256
set background=dark     " Dark solarized
colorscheme solarized
set colorcolumn=80      " Highlight 80th column

"" Whitespace
set expandtab           " Tabs consist of spaces
set tabstop=4           " Tabs are four spaces
set shiftwidth=4        " Tabs appear as four spaces
set softtabstop=4       " Treats Tabs like normal, but they consist of spaces
set listchars=tab:\ \ ,trail:·                  " These lines highlight
set list                                        " various trailing
highlight SpecialKey ctermfg=66 guifg=#649A9A   " whitespace characters

"" Behaviour
set incsearch           " Search as you type
set ignorecase          " Required for smartcase
set smartcase           " Case sensitive when uppercase is present
set autoindent          " Better auto-indenting
set smartindent         " with these two on
set relativenumber      " So good, just so good, try it
set number              " Doesn't replace relnum

"" Misc
set history=100



""" Mapping

"" No more shift every second keystroke
nnoremap ; :

"" Sane behaviour on long lines, stolen from @Sirupsen
nmap k gk
nmap j gj
noremap H ^
noremap L $

"" For inserting to and from the system clipboard quickly
nnoremap <C-y> "*y
nnoremap <C-i> "*p



""" Set syntax hightlighting for strange filetypes
autocmd! BufNewFile,BufRead *.ino setlocal ft=cpp
autocmd! BufNewFile,BufRead *.scad setlocal ft=cpp
autocmd! BufNewFile,BufRead *.md setlocal ft=markdown



""" LaTeX support
filetype plugin indent on
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"
set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after
