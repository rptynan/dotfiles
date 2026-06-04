""" General

"" First
set nocompatible
scriptencoding utf-8
set encoding=utf-8

"" Appearance
syntax enable
set t_Co=256
set colorcolumn=120     " Highlight textwidth column
set textwidth=120       " Set this to 120
autocmd FileType python setlocal colorcolumn=88 textwidth=88
autocmd FileType go setlocal colorcolumn=88,120 textwidth=120
set relativenumber      " So good, just so good, try it
set number              " Doesn't replace relnum
set cursorline          " make current line stand out
set cursorcolumn        " also make the column stand out, useful for blocks
set hlsearch            " Highlight current search terms
set signcolumn=number   " Show errors/lints/etc in number column not their own one

"" Whitespace
set expandtab           " Tabs consist of spaces
set tabstop=2           " Tabs are four spaces
set shiftwidth=2        " Tabs appear as four spaces
set softtabstop=2       " Treats Tabs like normal, but they consist of spaces
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
set hidden              " Don't require :w if switching away from mod'd buffer
set backspace=2         " TODO why?

"" Misc
set history=10000       " Larger history
set tabpagemax=100      " More tabs
set showcmd             " Show number of lines selected in visual mode
set spell               " I need spellcheck
set tags=tags;~         " Search for tags up to home directory



""" Mapping

"" Leader key is space, mostly because \ changes location between US and UK keyboards
let mapleader=" "

"" Sane behaviour on long lines, stolen from @Sirupsen
nmap k gk
nmap j gj
noremap H ^
noremap L $

"" For inserting to and from the system clipboard by default
set clipboard=unnamed

"" For clearing a line *cough* whitespace
map <Leader><Leader> 0d$

"" Set folding when needed
nmap <F6> :setlocal foldmethod=indent<CR>

"" For easier hexmode
nmap <F5> :Hexmode<CR>

"" Toggle numbers
map <Leader>m :set nu!<CR> :set rnu!<CR>

"" Swap buffers
map <Leader>g <c-^>
map <Leader>p :bp<CR>
map <Leader>n :bn<CR>

"" Swap between .cpp/et.h etc
map <Leader>h :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

"" Tell tmux to repeat the last command in certain panes
map <Leader>0 :exe "!tmux send -t 0 Up Enter"<CR><CR>
map <Leader>1 :exe "!tmux send -t 1 Up Enter"<CR><CR>
map <Leader>2 :exe "!tmux send -t 2 Up Enter"<CR><CR>
map <Leader>3 :exe "!tmux send -t 3 Up Enter"<CR><CR>
map <Leader>4 :exe "!tmux send -t 4 Up Enter"<CR><CR>
map <Leader>5 :exe "!tmux send -t 5 Up Enter"<CR><CR>
map <Leader>6 :exe "!tmux send -t 6 Up Enter"<CR><CR>
map <Leader>7 :exe "!tmux send -t 7 Up Enter"<CR><CR>
map <Leader>8 :exe "!tmux send -t 8 Up Enter"<CR><CR>
map <Leader>9 :exe "!tmux send -t 9 Up Enter"<CR><CR>

"" Easier explore
map <Leader>d :Ex<CR>

"" Experimental: Throw the current word under the cursor into rg in the opposite pain. Maybe easier just to do this in
"" fzf somehow.
nnoremap <leader>* :exe '!tmux send -t 1 "rg ' . expand('<cword>') . '" Enter'<CR><CR>
"" Experimental: Grab current file path and put into system clipboard
nnoremap <leader>] :let @+ = expand("%")<CR>

"" Make the window just wide enough to show 120 chars
nnoremap <leader>q :vertical resize 124<CR>
"" Easier ctr-w =
nnoremap <leader>= :horizontal wincmd =<CR>

"" Helpers for three-way merges
command! -range=% DiffLeft <line1>,<line2>diffget //2
command! -range=% DiffRight <line1>,<line2>diffget //3


"" Zooming panes
function! WinZoomToggle() abort
    if ! exists('w:WinZoomIsZoomed')
        let w:WinZoomIsZoomed = 0
    endif
    if w:WinZoomIsZoomed == 0
        let w:WinZoomOldWidth = winwidth(0)
        let w:WinZoomOldHeight = winheight(0)
        wincmd _
        wincmd |
        let w:WinZoomIsZoomed = 1
    elseif w:WinZoomIsZoomed == 1
        execute "resize " . w:WinZoomOldHeight
        execute "vertical resize " . w:WinZoomOldWidth
        let w:WinZoomIsZoomed = 0
    endif
endfunction

nnoremap <leader>z :call WinZoomToggle()<CR>

"" Don't jump when highlighting with *
nnoremap * *``

"" Can select text with v (e.g. vi') and then do <leader>64 to base64 decode it
vnoremap <leader>64 c<c-r>=system('base64 --decode', @")<cr><esc>

"" Easier splits (matches fzf bindings)
map <leader>v :vsplit<CR>
map <leader>x :split<CR>


"" Helpers for dark/light colorscheme
function! LightMode()
  set background=light
endfunction
command! -range -nargs=0 LightMode call LightMode()
function! DarkMode()
  set background=dark
endfunction
command! -range -nargs=0 DarkMode call DarkMode()

"" Helpers for dealing with json
function! FormatJSON() range
    execute a:firstline . ',' . a:lastline . '!jq "."'
endfunction
function! CompactJSON() range
    execute a:firstline . ',' . a:lastline . '!jq -c "."'
endfunction
command! -range=% -nargs=0 FormatJSON <line1>,<line2>call FormatJSON()
command! -range=% -nargs=0 CompactJSON <line1>,<line2>call CompactJSON()


""" Syntax options
"" File types
autocmd! BufNewFile,BufRead *.ino setlocal ft=cpp
autocmd! BufNewFile,BufRead *.scad setlocal ft=cpp
autocmd! BufNewFile,BufRead *.pl setlocal ft=prolog
"" Custom Commentary things
autocmd FileType sml set commentstring=\(\*\ %s\ \*\)
"" Match <> brackets like {},(),etc
set matchpairs+=<:>


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


""" vim-wordmotion
let g:wordmotion_prefix='<Leader>'  " wordmotion uses leader key


""" vim-tmux-navigator
" Don't let netrw override <C-l> to move between tmux panes
" https://github.com/christoomey/vim-tmux-navigator/issues/189
augroup netrw_mapping
  autocmd!
  autocmd filetype netrw call NetrwMapping()
augroup END
function! NetrwMapping()
  nnoremap <silent> <buffer> <c-l> :TmuxNavigateRight<CR>
endfunction


""" New nvim stuff
let g:python3_host_prog = expand('~/.config/nvim/venv/bin/python')
set termguicolors
lua require('init')
