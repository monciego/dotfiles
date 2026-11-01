" Minimal Vim config: no plugins, mirrors the basics of ~/dotfiles/nvim.
" Vim is the system default editor here, so this is what git commit,
" git rebase -i, crontab -e and sudoedit open.

set nocompatible
filetype plugin indent on
syntax on

" Leader
let mapleader = " "
let maplocalleader = " "

" UI
set number relativenumber
set signcolumn=yes
set nowrap linebreak
set scrolloff=10 sidescrolloff=8
set laststatus=2 ruler showcmd
set noshowmode
set wildmenu wildoptions=pum
set list
" Set with let so the trailing spaces can't be stripped by an editor
let &listchars = 'tab:│ ,trail:·,nbsp:␣'
let &fillchars = 'eob: ,vert:│'
set shortmess+=cI
set belloff=all

" Colors: built-in habamax with your #181818 background and yellow cursor
if has('termguicolors')
  set termguicolors
  " Needed for true colour inside tmux
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
set background=dark
augroup ColorOverrides
  autocmd!
  autocmd ColorScheme * highlight Normal guibg=#181818
        \ | highlight EndOfBuffer guibg=#181818
        \ | highlight SignColumn guibg=#181818
        \ | highlight LineNr guibg=#181818
        \ | call s:StatuslineColors()
augroup END

" Statusline: same layout and colors as lualine in nvim
"   [ mode ][ branch ] path [+]          utf-8  filetype [ line:col ]
function! s:StatuslineColors() abort
  highlight StatusLine   guifg=#ebdbb2 guibg=#1c1c1c gui=NONE cterm=NONE
  highlight StatusLineNC guifg=#928374 guibg=#1c1c1c gui=NONE cterm=NONE
  highlight StlB         guifg=#ebdbb2 guibg=#282828
  highlight StlNormal    guifg=#ebdbb2 guibg=#3c3836
  highlight StlInsert    guifg=#1c1c1c guibg=#83a598
  highlight StlVisual    guifg=#1c1c1c guibg=#d3869b
  highlight StlReplace   guifg=#1c1c1c guibg=#fb4934
  highlight StlCommand   guifg=#1c1c1c guibg=#fabd2f
endfunction

let s:modes = {
      \ 'n': ['NORMAL', 'StlNormal'], 'i': ['INSERT', 'StlInsert'],
      \ 'v': ['VISUAL', 'StlVisual'], 'V': ['V-LINE', 'StlVisual'], "\<C-v>": ['V-BLOCK', 'StlVisual'],
      \ 'R': ['REPLACE', 'StlReplace'], 'c': ['COMMAND', 'StlCommand'], 't': ['TERMINAL', 'StlInsert'],
      \ }

function! s:GitBranch() abort
  let l:dir = expand('%:p:h')
  let b:stl_branch = isdirectory(l:dir)
        \ ? trim(system('git -C ' . shellescape(l:dir) . ' branch --show-current 2>/dev/null'))
        \ : ''
endfunction
augroup StatuslineBranch
  autocmd!
  autocmd BufEnter,FocusGained,ShellCmdPost * call s:GitBranch()
augroup END

function! Statusline() abort
  if g:statusline_winid != win_getid()
    return ' %f'
  endif
  let [l:name, l:hl] = get(s:modes, mode(), ['NORMAL', 'StlNormal'])
  let l:branch = get(b:, 'stl_branch', '')
  let l:s = '%#' . l:hl . '#  ' . l:name . ' '
  let l:s .= empty(l:branch) ? '' : '%#StlB#  ' . l:branch . ' '
  let l:s .= '%#StatusLine# %f%{&modified ? " [+]" : ""}%{&readonly ? " " : ""}'
  let l:s .= '%=' . (winwidth(0) > 100 ? '%{&fenc ?? &enc}  %{&ft} ' : '')
  let l:s .= '%#StlB# %l:%c '
  return l:s
endfunction
set statusline=%!Statusline()

silent! colorscheme habamax

" Cursor: block in normal, bar in insert, underline in replace (Ghostty/tmux)
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"
let &t_ti .= "\<Esc>]12;#fabd2f\x7"
set ttimeout ttimeoutlen=10

" Tabs & indentation
set tabstop=2 shiftwidth=2 softtabstop=2 expandtab
set autoindent smartindent
set backspace=indent,eol,start

" Search
set incsearch nohlsearch ignorecase smartcase

" Files
set encoding=utf-8
set hidden autoread confirm
set nobackup nowritebackup noswapfile
set undofile
if !isdirectory($HOME . '/.vim/undo')
  call mkdir($HOME . '/.vim/undo', 'p', 0700)
endif
set undodir=~/.vim/undo//

" Clipboard & mouse
set clipboard=unnamedplus
set mouse=a
set updatetime=250 timeoutlen=300

" Commit messages: wrap at 72, spell check
augroup FileTypeTweaks
  autocmd!
  autocmd FileType gitcommit setlocal textwidth=72 colorcolumn=73 spell
  autocmd FileType markdown,text setlocal wrap spell
augroup END

" Jump back to the last cursor position when reopening a file (not for commits)
augroup RestoreCursor
  autocmd!
  autocmd BufReadPost * if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line('$')
        \ | execute "normal! g`\"" | endif
augroup END

" ---- Keymaps (same as Neovim) ----
nnoremap <Space> <Nop>
inoremap jk <Esc>
inoremap kj <Esc>
nnoremap <silent> <C-s> :w<CR>
nnoremap <silent> <C-q> :q<CR>
nnoremap x "_x
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap <expr> j v:count == 0 ? 'gj' : 'j'
nnoremap <expr> k v:count == 0 ? 'gk' : 'k'
xnoremap < <gv
xnoremap > >gv
" Move selected lines (J/K in visual; Alt keys aren't reliable in terminal Vim)
xnoremap <silent> J :m '>+1<CR>gv=gv
xnoremap <silent> K :m '<-2<CR>gv=gv
xnoremap p "_dP
nnoremap <silent> <Tab> :bnext<CR>
nnoremap <silent> <S-Tab> :bprevious<CR>
nnoremap <silent> <leader>c :bdelete<CR>
nnoremap <leader>v <C-w>v
nnoremap <leader>h <C-w>s
nnoremap <leader>se <C-w>=
nnoremap <silent> <leader>xs :close<CR>
nnoremap <silent> <leader>lw :set wrap!<CR>
nnoremap <leader>j *``cgn
nnoremap <leader>y "+y
xnoremap <leader>y "+y
nnoremap <leader>Y "+Y
" File explorer (netrw, built in)
nnoremap <silent> <leader>e :Lexplore<CR>
let g:netrw_banner = 0
let g:netrw_winsize = 25
let g:netrw_liststyle = 3
