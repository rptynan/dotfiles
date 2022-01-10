""" General

"" First
set nocompatible

"" Appearance
syntax enable
set t_Co=256
set background=dark     " Dark solarized
"colorscheme solarized  " Put to end because of NeoBundle
set colorcolumn=120     " Highlight textwidth column
set textwidth=120       " Set this to 120 (TODO make this only apply to JS & TS)
set relativenumber      " So good, just so good, try it
set number              " Doesn't replace relnum
set cursorline          " make current line stand out
set hlsearch            " Highlight current search terms

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

"" For inserting to and from the system clipboard quickly
nnoremap <C-y> "*y
nnoremap <C-i> "*p

"" For clearing a line *cough* whitespace
map <Leader><Leader> 0d$

"" Set folding when needed
nmap <F6> :setlocal foldmethod=indent<CR>

"" For easier hexmode
nmap <F5> :Hexmode<CR>

"" Toggle numbers
map <Leader>n :set nu!<CR> :set rnu!<CR>

"" Swap buffers
map <Leader>g :b#<CR>

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
map <Leader>e :Ex<CR>

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


""" Syntax options
"" File types
autocmd! BufNewFile,BufRead *.ino setlocal ft=cpp
autocmd! BufNewFile,BufRead *.scad setlocal ft=cpp
autocmd! BufNewFile,BufRead *.pl setlocal ft=prolog
"" Custom Commentary things
autocmd FileType sml set commentstring=\(\*\ %s\ \*\)
"" Match <> brackets like {},(),etc
set matchpairs+=<:>


""" NeoBundle support

"" Necessary
set runtimepath+=~/.vim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.vim/bundle'))
NeoBundleFetch 'Shougo/neobundle.vim'

"" List of plugins to install and keep
NeoBundle 'tpope/vim-commentary'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'fidian/hexmode'
NeoBundle 'tpope/vim-surround'
NeoBundle 'hhvm/vim-hack'
NeoBundle 'w0rp/ale'
NeoBundle 'junegunn/fzf.vim'
NeoBundle 'tpope/vim-eunuch'
NeoBundle 'jeetsukumaran/vim-indentwise'
NeoBundle 'christoomey/vim-tmux-navigator'
NeoBundle 'chaoren/vim-wordmotion'
NeoBundle 'tpope/vim-abolish'
NeoBundle 'junegunn/vader.vim'
NeoBundle 'vim-airline/vim-airline'
NeoBundle 'vim-airline/vim-airline-themes'
source ~/.fzf/plugin/fzf.vim    " Needed by fzf.vim

"" Necessary
call neobundle#end()
filetype plugin indent on
NeoBundleCheck


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


""" Tagbar
map <leader>b :Tagbar<CR>


""" Airline
" AirlineTheme solarized
let g:airline_solarized_bg='dark'
let g:airline_powerline_fonts=1


""" ALE
nmap <silent> <C-p> <Plug>(ale_previous_wrap)
nmap <silent> <C-n> <Plug>(ale_next_wrap)
"" Config
set re=0 " apparently makes typescript syntax highlighting not lag
" \   'javascript': ['eslint', 'flow'],
let g:ale_linters = {
\   'typescript': ['eslint', 'tsserver'],
\   'php': ['hack'],
\   'hack': ['hack', 'hhast'],
\   'python': ['pyre', 'pep8'],
\   'cpp': ['cquery_buck', 'clangcheck'],
\}
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'typescript': ['prettier'],
\   'javascript': ['prettier'],
\   'php': [],
\   'hack': [],
\   'python': ['isort', 'black'],
\   'cpp': ['clang-format'],
\}
command! HackFMTEnableBuffer let b:ale_fixers = {
\   'php': ['hackfmt'],
\   'hack': ['hackfmt'],
\}
command! ALEClearBufferFixers let b:ale_fixers = {}
"" Don't run on buck targets
let g:ale_pattern_options = {
\ 'TARGETS$': {'ale_linters': [], 'ale_fixers': []},
\}
let g:ale_pattern_options_enabled = 1
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1 " Seems to really slow things down
" let g:ale_lint_on_enter = 1
let g:ale_echo_msg_format = '[%linter%] %s'
"" Various python things that I stole from @pmh
let g:ale_python_autopep8_use_global=1
let g:ale_python_flake8_use_global=1
let g:ale_python_isort_use_global=1
let g:ale_python_mypy_use_global=1
let g:ale_python_mypy_options='--ignore-missing-imports --cache-dir /tmp/rpt_mypy_cache'
let g:ale_python_pycodestyle_use_global=1
let g:ale_python_pylint_use_global=1
let g:ale_python_yapf_use_global=1
" Press `K` to view the type in the gutter
nnoremap <silent> K :ALEHover<CR>
" Type `gd` to go to definition
nnoremap <silent> gd :ALEGoToDefinition<CR>
" show type on hover in a floating bubble TODO
if v:version >= 801
    set balloonevalterm
    let g:ale_set_balloons = 1
    let balloondelay = 250
endif

nnoremap <leader>i :ALECodeAction<CR>



""" vim-wordmotion
let g:wordmotion_prefix='<Leader>'  " wordmotion uses leader key


""" fzf
" Use \a for buffers
map <Leader>a :Buffers<CR>
" File search for github files (should be good proxy for working set?)
map <Leader>f :GFiles<CR>
" Same but for word under cursor
" map <Leader>F "zyiw :GFiles<CR> <C-r>z TODO not a happy boy
" Similar to above, but text search instead of filename search
map <Leader>s :Rg<CR>
map <Leader>S "zyiw :Rg <C-r>z<CR>


""" hackfmt per line from @njg
function! HackFmt() range
  let start = a:firstline
  let end = a:lastline
  " current range contents, for comparison
  let curr = join(getline(start, end), "\n")."\n"
  " the replacement command (passes the full buffer as stdin)
  let cmd = "hackfmt --line-width=80 --range ".line2byte(start)." ".line2byte(end+1)
  let output = system(cmd, join(getline(1, '$'), "\n"))

  " if they are the (case-sensitive) same, then don't touch the file
  if curr ==# output
    return
  endif

  " otherwise, delete what's there and put the new output
  execute start.",".end."d"
  execute start-1."put =output"
endfunction
command! -range -nargs=0 HackFmt <line1>,<line2>call HackFmt()


""" Needs to go at the end
colorscheme solarized
