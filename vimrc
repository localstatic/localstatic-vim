
" Modeline and Notes {
" vim: set filetype=vim foldmarker={,} foldlevel=0 foldmethod=marker: 
" }

" Environment {
set nocompatible

" Windows Compatible {
" On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
" across (heterogeneous) systems easier.
if has('win32') || has('win64')
  set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif
" }

" }

" Vim-Plug {

call plug#begin('~/.vim/plugged')

" Plugins {
" General {
Plug 'jlanzarotta/bufexplorer'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'vimwiki/vimwiki'
Plug 'yssl/QFEnter'
" }

" Colorschemes {
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'chriskempson/base16-vim'
" }

" Development Tools {
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'dense-analysis/ale'
Plug 'editorconfig/editorconfig-vim'
Plug 'ianks/vim-tsx'
" Plug 'ludovicchabant/vim-gutentags'
Plug 'rizzatti/dash.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'tommcdo/vim-fubitive' " Fugitive browse handler (support Bitbucket URLs in `:Gbrowse`)

" FZF Integration {
if exists('/usr/local/opt/fzf')
  Plug '/usr/local/opt/fzf'
else
  Plug 'junegunn/fzf', { 'do': './install --bin' }
endif
Plug 'junegunn/fzf.vim'
" }
" }

" }

call plug#end()
" }

" General {
filetype plugin indent on
syntax on

set encoding=utf-8
scriptencoding utf-8

set mouse=a

set shortmess+=mr " vim default: filnxtToOS, vi default: S
set viewoptions=folds,options,cursor,unix,slash
set virtualedit=onemore
set history=1000
set hidden
set formatoptions+=j
set updatetime=1000 " vim default: 4000, but lower a bit to make gitgutter plugin snappier

set nobackup
set noswapfile

if has('syntax')
  set spelllang=en_us
endif

if has('persistent_undo')
  set undofile
endif

au BufWinLeave * silent! mkview  " make vim save view (folds, cursor, etc as specified in viewoptions above)
au BufWinEnter * silent! loadview " make vim load view (folds, cursor, etc as specified in viewoptions above)
" }

" Vim UI {
set background=dark
set showmode

set cursorline

if has('cmdline_info')
  set ruler
  set rulerformat=%30(%=%y%m%r%w\ %l,%c%V\ %P%)
  set showcmd
endif

if has('statusline')
  set laststatus=2

  function! LinterStatus() abort " {
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? '' : printf(
          \   '%dW %dE',
          \   all_non_errors,
          \   all_errors
          \)
  endfunction " }

  set statusline=

  " Break up statusline into one segment per statement to facilitate easy
  " moving around and enabling/disabling of individual parts
  "set statusline+=\ %{getcwd()}             " Current directory
  set statusline+=\ %<%f\  "                " Filename
  set statusline+=\ [%{&ff}]%y              " Filetype
  set statusline+=%=                        " split between left- and right-aligned info
  " set statusline+=%{gutentags#statusline('[',']')} " current tag (function, etc)
  set statusline+=\ %{ObsessionStatus()}    " vim-obsession status
  set statusline+=%#warningmsg#%{LinterStatus()}%* " Linter-provided error info
  set statusline+=%15(%m%r%w\ %l,%c%V\ %P%) " flags, line numbers, etc
endif

set backspace=indent,eol,start
set linespace=1
set number
set relativenumber
set showmatch
set winminheight=0

set incsearch
set hlsearch
set ignorecase
set smartcase

set wildmenu
set wildmode=list:longest,full

set whichwrap=b,s,h,l,<,>,[,]

set scrolljump=5
set scrolloff=5

set foldenable

set list
set listchars=tab:,.,trail:.,extends:#,precedes:#,nbsp:.

set splitright
set splitbelow
" }

" Formatting {
set nowrap
set autoindent
set noautoread
set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2

set textwidth=100

set matchpairs+=<:>
" }

" Filetype-specific settings {
augroup filetypesettings
  autocmd!
  autocmd FileType python setlocal noexpandtab
augroup END

" }

" Key Mappings {

let mapleader = ' '

" Wrapped lines goes down/up to next row, rather than next line in file.
nnoremap j gj
nnoremap k gk

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

" Clear highlighted search
nmap <silent> <leader>/ :nohlsearch<CR>

" Change Working Directory to that of the current file
cmap cd. lcd %:p:h

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Fix home and end keybindings for screen, particularly on mac
" - for some reason this fixes the arrow keys too. huh.
map [F $
imap [F $
map [H g0
imap [H g0

" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null

" Some helpers to edit mode
" http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>ew :edit %%
map <leader>es :split %%
map <leader>ev :vsplit %%
map <leader>et :tabedit %%

" Adjust viewports
map <leader>_ <C-w>_
map <leader>= <C-w>=

" netrw settings
let g:netrw_home = $HOME
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

" Validate & Format XML files
map <leader>xml :silent 1,$!xmllint --format --recover - 2>/dev/null

" Validate & Format JSON files
nmap <leader>json :%!jsonlint<CR>

" Convert Markdown to HTML
nmap <leader>md :%!multimarkdown<CR>

" Insert current timestamp (http://vim.wikia.com/wiki/Insert_current_date_or_time)
:nnoremap <leader>dts "=strftime("%c")<CR>PA

" Fix syntax highlighting
map <leader>syn :syntax sync fromstart<CR>

" Trim trailing whitespace
map <leader>trail :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))<CR>

" }

" Grep {
if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m,%f:%l:%m
elseif executable('ag')
  " Use ag instead of grep
  set grepprg=ag\ --vimgrep\ $*
  set grepformat=%f:%l:%c:%m
endif

" grep word under cursor
nmap <leader>gr :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
" }

" Plugin settings {

" Ack.vim {
if executable('rg')
  let g:ackprg = 'rg --vimgrep --smart-case --no-heading'
elseif executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

map <leader>ag :Ack!<CR>
" }

" ALE {
let g:ale_fix_on_save = 1
let g:ale_linters = {
\  'typescript': ['tslint'],
\ }
let g:ale_fixers = {
\  'typescript': ['prettier'],
\ }
" }

" BufExplorer {
let g:bufExplorerFindActive=0
" }

" Editorconfig {
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
" }

" NerdCommenter {
let NERDSpaceDelims=1
" }

" Rooter {
let g:rooter_cd_cmd="lcd" " Use local :lcd instead of :cd
let g:rooter_patterns = ['.git/', '.git', '.hg/', '._darcs/', '.bzr/', '.svn/']
map <silent> <leader>pcd <Plug>RooterChangeToRootDirectory
" }

" vim-javascript {
let g:javascript_plugin_jsdoc = 1
" }

" vim-json {
let g:vim_json_syntax_conceal = 0
" }

" vim-fugitive {
map <leader>gb :Gblame<CR>
" }

" vimwiki {

let wiki_1 = {}
let wiki_1.path = '~/Nextcloud/Documents/notebook/'
let wiki_1.syntax = 'markdown'
let wiki_1.ext = '.md'

let wiki_2 = {}
let wiki_2.path = '~/Documents/notes/'
let wiki_2.syntax = 'markdown'
let wiki_2.ext = '.md'

let g:vimwiki_list = [wiki_1, wiki_2]

nmap -- <Plug>VimwikiRemoveHeaderLevel

" https://frostyx.cz/posts/vimwiki-diary-template
au BufNewFile ~/Nextcloud/Documents/notebook/diary/*.md :silent 0r !~/.vim/bin/generate-vimwiki-diary-template '%'

" }

" GUI Settings {

if has('gui_running')
  colorscheme base16-tomorrow-night

  if has("gui_gtk2") || has("gui_gtk3")
    set guifont=Hack\ 15
  else
    set guifont=Hack:h15,Anonymous\ Pro\ for\ Powerline:h14,Anonymous\ Pro:h14,Menlo\ Regular:h15,Andale\ Mono\ Regular:h16,Consolas\ Regular:h16,Courier\ New\ Regular:h18
  endif
else
  colorscheme Tomorrow-Night
endif

" }

" Functions {

function! InitializeDirectories()
  let separator = "."
  let parent = $HOME
  let prefix = '.vim'
  let dir_list = {
        \ 'backup': 'backupdir',
        \ 'swap': 'directory',
        \ 'views': 'viewdir'}

  if has('persistent_undo')
    let dir_list['undo'] = 'undodir'
  endif

  for [dirname, settingname] in items(dir_list)
    let directory = parent . '/' . prefix . dirname . "/"
    if exists("*mkdir")
      if !isdirectory(directory)
        call mkdir(directory)
      endif
    endif
    if !isdirectory(directory)
      echo "Warning: Unable to create backup directory: " . directory
      echo "Try: mkdir -p " . directory
    else
      let directory = substitute(directory, " ", "\\\\ ", "g")
      exec "set " . settingname . "=" . directory
    endif
  endfor
endfunction
call InitializeDirectories()

" source: `:help VimwikiLinkHandler'
function! VimwikiLinkHandler(link)
  " Use Vim to open external files with the 'vfile:' scheme.  E.g.:
  "   1) [[vfile:~/Code/PythonProject/abc123.py]]
  "   2) [[vfile:./|Wiki Home]]
  let link = a:link
  if link =~# '^vfile:'
    let link = link[1:]
  else
    return 0
  endif
  let link_infos = vimwiki#base#resolve_link(link)
  if link_infos.filename == ''
    echomsg 'Vimwiki Error: Unable to resolve link!'
    return 0
  else
    exe 'tabnew ' . fnameescape(link_infos.filename)
    return 1
  endif
endfunction

" }

" Use local vimrc if available {
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
" }

" Use local gvimrc if available and gui is running {
if has('gui_running') && filereadable(expand("~/.gvimrc.local"))
  source ~/.gvimrc.local
endif
" }

