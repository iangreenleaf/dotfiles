" My favoritest .vimrc

" Sources of inspiration (among others):
" http://nvie.com/posts/how-i-boosted-my-vim/
" http://stevelosh.com/blog/2010/09/coming-home-to-vim/
" http://amix.dk/vim/vimrc.html
"
" Plugins:
" pathogen
" matchit.vim
" surround.vim
" repeat.vim
" Command-T
" Fugitive
" Rails.vim

" Load up plugins with pathogen
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" Load saved session file, if it exists
if filereadable(expand("~/.dotfiles/vim/session.vim")) && argc() == 0
  autocmd GUIEnter * :source ~/.dotfiles/vim/session.vim
end

" Set the leader key
let mapleader=","
let g:mapleader=","

" Force a reload of ftdetect (for pathogen)
filetype off

" This enables automatic indentation as you type.
filetype indent on

" Load filetype-specific plugins
filetype plugin on

" Allow per-directory .vimrc files
set exrc
" Disable unsafe commands in local .vimrc files
set secure
" Allow modelines
set modeline

" Set mouse support when it's available
if has('mouse')
  set mouse=a
endif

" Backspace all the things
set backspace=indent,eol,start

" Syntax highlighting
syntax enable

" Spellcheck
set spell

" Indentation
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2

" Ignore case in search, unless search is not all lowercase
set ignorecase
set smartcase

" No search highlighting
set nohlsearch

" Line numbering
set number

" No folding most of the time
set foldmethod=manual

" Highlight tabs and trailing whitespace
set list
set listchars=tab:➙.,trail:╍,extends:❱,precedes:❰,nbsp:░

" Turn off tab highlighting for specific file types
autocmd FileType gitcommit set listchars+=tab:\ \ 

" Give Vim some extra places to look for a tags file
set tags+=../tags,../TAGS,../../tags,../../TAGS

" Highlight .iced files as coffeescript
au BufRead,BufNewFile *.iced set filetype=coffee

" Make Vim highlight .html files like PHP
au BufRead,BufNewFile *.html set filetype=php
" Set appropriate formatoptions on alternate PHP extensions
" (this mostly helps make comment blocks behave appropriately)
au BufRead,BufNewFile *.html setlocal fo=qrowcb
au BufRead,BufNewFile *.inc setlocal fo=qrowcb

" Use fancy colors with 256 xterm
" :set t_AB=m
" :set t_AF=m

" Choose a color scheme
if has("gui_running")
  "colo 256_blackdust
  "colo desert
  colo slate
  "colo github
else
  if !has('nvim')
    set term=xterm-256color
  end
  colo desertEx
endif

" Map F1 to Esc
map <F1> <Esc>
imap <F1> <Esc>

" Set font
if has("gui_macvim")
  try
    set guifont=Anonymous\ Pro:h13
  catch
    set guifont=Monaco:h12
  endtry
elseif has("gui_gtk2") || has("gui_gtk3")
  set guifont=Luxi\ Mono\ 10
else
  set guifont=Luxi\ Mono:h10
endif

" Set the term to something screen handles
if !has('nvim')
  set ttymouse=xterm2
endif

" Always start at the beginning of the commit msg
autocmd FileType gitcommit call setpos('.', [0, 1, 1, 0])

" Don't hard wrap lines
set textwidth=0
set wrapmargin=0

" Do soft wrap lines
set wrap
set showbreak=⏎\ 
highlight NonText gui=NONE

" Always keep some context above/below current line
set so=4

" Collapse split windows fully
:set winminheight=0

" Don't resize split windows automatically
set noequalalways

" Always show status line
set laststatus=2

" Status line content
"let g:airline_section_b = '%<%f'
"let g:airline_section_b = airline#section#create_left(['ffenc','file'])
let g:airline_section_b = '%m%r%=%-9.(%y%)'
let g:airline_section_x = '%10.10(❲c%b◦0x%B%)❳'
let g:airline_section_y = '%-12.(%l,%c%V%)'
let g:airline_section_z = '%P'
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#default#section_truncate_width = {
    \ 'b': 50,
    \ 'x': 88,
    \ 'y': 70,
    \ }
let g:airline_inactive_collapse=0
let g:airline#extensions#default#layout = [
    \ [ 'c', 'b' ],
    \ [ 'x', 'y', 'z', 'warning' ]
    \ ]
"set statusline=%<%f\ %m%r%=%-9.(%y%)\ %10.10(❲c%b◦0x%B%)❳\ %-12.(%l,%c%V%)\ %P

" Change the behavior of tab completion
set wildmenu
set wildmode=longest:full

" Change behavior of autocompletion
set completeopt=longest,menuone
inoremap <cr> <c-r>=<SID>SpecialCompletionCRBehavior()<cr>
function! s:SpecialCompletionCRBehavior()
  return pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endfunction
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <C-Space> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" No toolbar or menubar
set guioptions-=T

" Fuzzy finder settings
nnoremap <leader>t :FZF<CR>
let g:fzf_action = {
  \ 'enter': 'split',
  \ 'ctrl-e': 'open',
  \ 'ctrl-v': 'vsplit' }

" Persistent undo
try
  set undodir=~/.vim/undo
  set undofile
catch
endtry

" Graphical undo
nnoremap <leader>u :GundoToggle<CR>

" Trash the current file
function! TrashPut(force)
  let trash_result=system("trash-put ".expand("%"))
  if trash_result != "" && !a:force
    echo trash_result
  elseif a:force
    bdelete!
  else
    bdelete
  endif
endfunction
command! -bang Trash call TrashPut(<bang>0)

" Save a file when you forgot to sudo
cmap w!! %!sudo tee > /dev/null %

" Reload .vimrc with :VimRC
command! VimRC :source $MYVIMRC

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" Strip HTML
command! -range StripHtml :<line1>,<line2>s/<[^>]\+>//g | :silent! <line1>,<line2>g/^\s*$/d
" Strip HTML, ignoring some tags. Takes one argument, like `img\|span\|p`
command! -nargs=1 -range StripHtmlExcept :<line1>,<line2>s/<\(\/\?\(<args>\)\)\@![^>]\+>//g | :silent! <line1>,<line2>g/^\s*$/d

" Whitespace cleanup with ,W
nnoremap <leader>W :%s/\s\+$//e<CR>:%s/ / /ge<CR>gg=G<CR>
vnoremap <leader>W :s/\s\+$//e<CR>gv:s/ / /ge<CR>gv=<CR>

" Delete without cluttering the yank register
nnoremap <leader>d "_d
nnoremap <leader>p "0p
vnoremap <leader>p "_dP

" :split and jump to a tag
nnoremap <leader>] <C-W>g<C-]>

" For surround.vim
" cs(s will convert to spaces, appropriately
let g:surround_{char2nr('s')} = " \r"

" For gist.vim
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1

" For go.vim
let g:go_fmt_fail_silently = 1

" For rainbow.vim
let g:rainbow_active = 1

" From http://amix.dk/blog/post/19334
" * and # in visual mode search for the selected thing
function! VisualSearch(direction) range
  let l:saved_reg = @"
  execute "normal! vgvy"

  let l:pattern = escape(@", '\\/.*$^~[]')
  let l:pattern = substitute(l:pattern, "\n$", "", "")

  if a:direction == 'b'
    execute "normal ?" . l:pattern
    ??
  elseif a:direction == 'f'
    execute "normal /" . l:pattern
    //
  endif

  let @/ = l:pattern
  let @" = l:saved_reg
endfunction
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

" Give command mode some CLI-type movement commands
:cnoremap <C-a>  <Home>
:cnoremap <C-e>  <End>

" Don't save the stupid .netrwhist file in config folder
let g:netrw_home=$XDG_CACHE_HOME.'/vim'

" Disable annoying IDE tooltips
if exists('&ballooneval')
  set noballooneval
endif
" Stupid netrw likes to clobber this setting
let g:netrw_nobeval = 1

" No incremental search
set noincsearch

" vim: filetype=vim
