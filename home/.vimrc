""" General

"" First
set nocompatible

"" Appearance
syntax enable
set t_Co=256
set background=dark     " Dark solarized
colorscheme solarized
set colorcolumn=80      " Highlight 80th column
set relativenumber      " So good, just so good, try it
set number              " Doesn't replace relnum

"" Whitespace
set expandtab           " Tabs consist of spaces
set tabstop=4           " Tabs are four spaces
set shiftwidth=4        " Tabs appear as four spaces
set softtabstop=4       " Treats Tabs like normal, but they consist of spaces
set smarttab            " Treats partial tabs as one group
set listchars=tab:\ \ ,trail:·                  " These lines highlight
set list                                        " various trailing
highlight SpecialKey ctermfg=66 guifg=#649A9A   " whitespace characters

"" Behaviour
set incsearch           " Search as you type
set ignorecase          " Required for smartcase
set smartcase           " Case sensitive when uppercase is present
set autoindent          " Better auto-indenting
set smartindent         " with these two on
set wildmenu            " <Tab> causes completion menu on commands
set scrolloff=5         " Keeps that many lines around cursor when scrolling

"" Misc
set history=100         " Larger history
set tabpagemax=100      " More tabs
set showcmd             " Show number of lines selected in visual mode



""" Mapping

"" No more shift every second keystroke (; turns out to actually be useful)
" nnoremap ; :

"" Sane behaviour on long lines, stolen from @Sirupsen
nmap k gk
nmap j gj
noremap H ^
noremap L $

"" For inserting to and from the system clipboard quickly
nnoremap <C-y> "*y
nnoremap <C-i> "*p

"" For clearing a line *cough* whitespace
map \ 0d$



""" Set syntax hightlighting for strange filetypes
autocmd! BufNewFile,BufRead *.ino setlocal ft=cpp
autocmd! BufNewFile,BufRead *.scad setlocal ft=cpp



""" NeoBundle support

"" Necessary
set runtimepath+=~/.vim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.vim/bundle'))
NeoBundleFetch 'Shougo/neobundle.vim'

"" List of plugins to install and keep
NeoBundle 'scrooloose/syntastic'
NeoBundle 'tpope/vim-commentary'
NeoBundle 'altercation/vim-colors-solarized'

"" Necessary
call neobundle#end()
filetype plugin indent on
NeoBundleCheck



""" Powerline support
let $PYTHONPATH='/usr/lib/python3.4/site-packages'
set laststatus=2



""" LaTeX support

"" Necessary
filetype plugin indent on
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"
set runtimepath+=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after

"" Compile to pdf by default
let g:Tex_DefaultTargetFormat='pdf'

"" Sane keybindings
nmap <F11> \lv
map <F12> :w <Bar> normal \ll<CR>



""" Syntastic supprt

"" Newbie defaults
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"" Nicer jumps
nmap <F10> :lnext<CR>
nmap <F9> :lprev<CR>
