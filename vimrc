
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
Plug 'rking/ag.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/bufexplorer.zip'
Plug 'yssl/QFEnter'
" }

" Colorschemes {
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'chriskempson/base16-vim'
" }

" Development Tools {
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'elzr/vim-json'
Plug 'leafgarland/typescript-vim'
Plug 'pangloss/vim-javascript'
Plug 'rizzatti/dash.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-fugitive'
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

set shortmess+=filmnrx " maybe also oOtT
set viewoptions=folds,options,cursor,unix,slash
set virtualedit=onemore
set history=1000
set hidden

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

  set statusline=

  " Break up statusline into one segment per statement to facilitate easy
  " moving around and enabling/disabling of individual parts
  "set statusline+=\ %{getcwd()}             " Current directory
  set statusline+=\ %<%f\  "                " Filename
  set statusline+=\ [%{&ff}]%y              " Filetype
  set statusline+=%=                        " split between left- and right-aligned info"
  set statusline+=%15(%m%r%w\ %l,%c%V\ %P%) " 
endif

set backspace=indent,eol,start
set linespace=1
set number
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

augroup filetypedetect
  autocmd!
  autocmd BufNew,BufNewFile,BufRead *.md,*.mkdn,*.markdown :set filetype=markdown
  autocmd BufNew,BufNewFile,BufRead *.sls :set filetype=yaml " Salt state files
  autocmd BufNew,BufNewFile,BufRead *.js :set filetype=javascript
  autocmd BufNew,BufNewFile,BufRead *.json :set filetype=json
  autocmd BufNew,BufNewFile,BufRead *.ts :set filetype=typescript
  autocmd BufNew,BufNewFile,BufRead *.html,*.htm :set filetype=html
  autocmd BufNew,BufNewFile,BufRead *.css :set filetype=css
augroup END
" }

" Key Mappings {

let mapleader = ','

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
"map <leader>gr :GoldenRatioResize<CR>

" Make netrw sort of like NERDTree
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
map <leader>t :Vexplore<CR>

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

" Plugin settings {

" Ag.vim {
map <leader>ag :Ag!<CR>
" }

" BufExplorer {
let g:bufExplorerFindActive=0
" }

" NerdTree {
map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
map <leader>e :NERDTreeFind<CR>
nmap <leader>nt :NERDTreeFind<CR>

let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr', '\.DS_Store']
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=0
let NERDTreeKeepTreeInNewTab=1
let NERDTreeWinSize=50
" }

" Rooter {
let g:rooter_use_lcd = 1 " Use local :lcd instead of :cd
let g:rooter_patterns = ['.git/', '.git', '.hg/', '._darcs/', '.bzr/', '.svn/']
map <silent> <leader>pcd <Plug>RooterChangeToRootDirectory
" }

" Syntastic {
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-", " proprietary attribute \"integrity\"", " proprietary attribute \"crossorigin\""]
let g:syntastic_typescript_checkers = ['tslint', 'tsc']
" }

" vim-javascript {
let g:javascript_plugin_jsdoc = 1
" }

" vim-json {
let g:vim_json_syntax_conceal = 0
" }

" vim-fugitive {
map <leader>gb :Gblame
" }

" }

" GUI Settings {

if has('gui_running')
  colorscheme base16-tomorrow-night

  set lines=60
  set columns=200
  set guifont=Hack:h15,Anonymous\ Pro\ for\ Powerline:h14,Anonymous\ Pro:h14,Menlo\ Regular:h15,Andale\ Mono\ Regular:h16,Consolas\ Regular:h16,Courier\ New\ Regular:h18
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

