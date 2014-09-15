"""General

""Appearance
:syntax enable
:set t_Co=256
"solarized
:set background=dark
:colorscheme solarized
"seoul256
"let g:seoul256_background = 233
":colorscheme seoul256
"grb256
":set background=dark
":colorscheme grb256

""Whitespace
:set autoindent
:set tabstop=4
:set shiftwidth=4
:set expandtab
:set listchars=tab:\ \ ,trail:·
:set list
:highlight SpecialKey ctermfg=66 guifg=#649A9A

""Mapping
nnoremap ; :
"nnoremap : ;

""Misc
:set relativenumber



"""Set syntax hightlighting for strange files
autocmd! BufNewFile,BufRead *.ino setlocal ft=cpp
autocmd! BufNewFile,BufRead *.scad setlocal ft=cpp
autocmd! BufNewFile,BufRead *.md setlocal ft=markdown



"""Insert one character command
":nnoremap s :exec "normal i".nr2char(getchar())."\e"<CR>
":nnoremap S :exec "normal a".nr2char(getchar())."\e"<CR>



"""LaTeX support
filetype plugin indent on
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"
set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after
