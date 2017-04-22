""" General

"" First
set nocompatible

"" Appearance
syntax enable
set t_Co=256
set background=dark     " Dark solarized
"colorscheme solarized  " Put to end because of NeoBundle
set colorcolumn=80      " Highlight 80th column
set relativenumber      " So good, just so good, try it
set number              " Doesn't replace relnum
set cursorline          " make current line stand out

"" Whitespace
" set expandtab           " Tabs consist of spaces
set noexpandtab         " Bsd style
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
set mouse=a             " Use a mouse normally in vim, handy
set hidden

"" Misc
set history=100         " Larger history
set tabpagemax=100      " More tabs
set showcmd             " Show number of lines selected in visual mode


""" Mapping

"" Sane behaviour on long lines, stolen from @Sirupsen
nmap k gk
nmap j gj
noremap H ^
noremap L $

"" For inserting to and from the system clipboard quickly
nnoremap <C-y> "*y
nnoremap <C-i> "*p

"" For clearing a line *cough* whitespace
map <Leader><Leader> 0d$

"" Set folding when needed
nmap <F6> :setlocal foldmethod=indent<CR>

"" For easier hexmode
nmap <F5> :Hexmode<CR>


""" Set syntax hightlighting for strange filetypes
autocmd! BufNewFile,BufRead *.ino setlocal ft=cpp
autocmd! BufNewFile,BufRead *.scad setlocal ft=cpp
autocmd! BufNewFile,BufRead *.pl setlocal ft=prolog


""" NeoBundle support

"" Necessary
set runtimepath+=~/.vim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.vim/bundle'))
NeoBundleFetch 'Shougo/neobundle.vim'

"" List of plugins to install and keep
NeoBundle 'tpope/vim-commentary'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'fidian/hexmode'
NeoBundle 'vim-scripts/occur.vim'

"" Necessary
call neobundle#end()
filetype plugin indent on
NeoBundleCheck


""" Powerline support
let $PYTHONPATH='/usr/lib/python3.4/site-packages'
set laststatus=2


""" Custom Commentary things
autocmd FileType sml set commentstring=\(\*\ %s\ \*\)


""" LaTeX support

"" Necessary
filetype plugin indent on
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"

"" Compile to pdf by default
let g:Tex_DefaultTargetFormat='pdf'

"" Sane keybindings
nmap <F11> \lv
map <F12> :w <Bar> normal \ll<CR>


""" Syntastic supprt

let g:syntastic_mode_map = { 'mode': 'passive' }
"" Newbie defaults
if has("Syntastic")
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*
endif

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

"" Mappings
" Toggle it on an off
nmap <F7> :SyntasticToggleMode<CR>
" Nicer jumps, jumps to the prev, selected and next.
nmap <F8> :lprev<CR>
nmap <F9> :ll<CR>
nmap <F10> :lnext<CR>

"" Options
let syntastic_cpp_compiler_options = '-std=c++11'


""" Tagbar
map <leader>b :Tagbar<CR>


""" Needs to go at the end
colorscheme solarized
