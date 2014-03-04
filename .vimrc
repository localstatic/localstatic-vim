
" Modeline and Notes {
" vim: set foldmarker={,} foldlevel=0 foldmethod=marker:
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

" Setup Bundle Support {
" The next two lines ensure that the ~/.vim/bundle/ system works
set rtp+=~/.vim/bundle/vundle
call vundle#rc()
" }
" }

" Bundles {

Bundle 'gmarik/vundle'

" Color schemes
Bundle 'chriskempson/vim-tomorrow-theme'
Bundle 'sjl/badwolf'
Bundle 'kellys'

" General
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/nerdcommenter'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-repeat'
Bundle 'bufexplorer.zip'
Bundle 'delimitMate.vim'
Bundle 'roman/golden-ratio'
Bundle 'ack.vim'

" Development
Bundle 'tpope/vim-fugitive'
Bundle 'vcscommand.vim'
Bundle 'scrooloose/syntastic'
Bundle 'majutsushi/tagbar'
Bundle 'Shougo/neocomplcache'
Bundle 'matchit.zip'
Bundle 'SirVer/ultisnips'

" HTML
Bundle 'othree/html5.vim'
Bundle 'vim-scripts/HTML-AutoCloseTag'
Bundle 'tpope/vim-ragtag'

" PHP
Bundle 'spf13/PIV'

" HAML/Sass/SCSS - I mostly care about Sass/SCSS
Bundle 'tpope/vim-haml'

" Ruby
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-rails'
Bundle 'ruby-matchit'

" }

" General {
filetype plugin indent on   " Automatically detect file types.
syntax on                   " syntax highlighting
set mouse=a                 " automatically enable mouse usage
scriptencoding utf-8

set shortmess+=filmnrxoOtT      " abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash " better unix / windows compatibility
set virtualedit=onemore         " allow for cursor beyond last character
set history=1000                " Store a ton of history (default is 20)
set hidden                      " allow buffer switching without saving

set nobackup " Don't create annoying backup files
set noswapfile " Swap files? Meh.

" Setting up the directories {
if has('persistent_undo')
	set undofile                " so is persistent undo ...
	set undolevels=1000         " maximum number of changes that can be undone
	set undoreload=10000        " maximum number lines to save for undo on a buffer reload
endif
" Could use * rather than *.*, but I prefer to leave .files unsaved
au BufWinLeave *.* silent! mkview  "make vim save view (state) (folds, cursor, etc)
au BufWinEnter *.* silent! loadview "make vim load view (state) (folds, cursor, etc)
" }
" }

" Vim UI {
set background=dark         " Assume a dark background
color desert
set showmode                    " display the current mode

set cursorline                  " highlight current line

if has('cmdline_info')
	set ruler                   " show the ruler
	set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
	set showcmd                 " show partial commands in status line and
	" selected characters/lines in visual mode
endif

if has('statusline')
	set laststatus=2

	" Broken down into easily includable segments
	set statusline=                          " empty line to facilitate easy moving around of segments
	"set statusline+=\ [%{getcwd()}]          " Current directory
	set statusline+=%W%H%M%R                  " Options
	set statusline+=\ %<%f\ 
	set statusline+=%{fugitive#statusline()} " Git Info
	set statusline+=\ [%{&ff}/%Y]            " Filetype
	set statusline+=%=                       " split between left- and right-aligned info"
	set statusline+=%-8.(%l,%c%V%)\ %p%%    " file nav info
endif

set backspace=indent,eol,start  " backspace for dummies
set linespace=0                 " No extra spaces between rows
set number                      " Line numbers on
set showmatch                   " show matching brackets/parenthesis
set incsearch                   " find as you type search
set hlsearch                    " highlight search terms
set winminheight=0              " windows can be 0 line high
set ignorecase                  " case insensitive search
set smartcase                   " case sensitive when uc present
set wildmenu                    " show list instead of just completing
set wildmode=list:longest,full  " command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]   " backspace and cursor keys wrap to
set scrolljump=5                " lines to scroll when cursor leaves screen
set scrolloff=3                 " minimum lines to keep above and below cursor
set foldenable                  " auto fold code
"set list
set nolist                      " Don't show list characters (tab, EOL, etc as set in listchars)
set listchars=tab:,.,trail:.,extends:#,nbsp:. " Highlight problematic whitespace
set splitright                  " New splits to the right
set splitbelow                  " New splits below
" }

" Formatting {
set nowrap                       " wrap long lines
set autoindent                   " indent at the same level of the previous line
set shiftwidth=4                 " use indents of 4 spaces
"set expandtab                    " tabs are spaces, not tabs
set noexpandtab                  " tabs are tabs, damnit!
set tabstop=4                    " an indentation every four columns
set softtabstop=4                " let backspace delete indent
"set matchpairs+=<:>              " match, to be used with % 
set pastetoggle=<F12>            " pastetoggle (sane indentation on pastes)
"set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
" Remove trailing whitespaces and ^M chars
"autocmd FileType c,cpp,java,php,js,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))
autocmd FileType python set noexpandtab
autocmd FileType ruby,eruby setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
"au FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"

augroup filetypedetect
    "autocmd BufNew,BufNewFile,BufRead *.txt,*.text,*.md,*.markdown :setfiletype markdown
    autocmd BufNew,BufNewFile,BufRead *.md,*.mkdn,*.markdown :set filetype=markdown
	autocmd BufNew,BufNewFile,BufRead *.module :set filetype=php " Drupal module
augroup END
" }

" Key (re)Mappings {

"The default leader is '\', but many people prefer ',' as it's in a standard
"location
let mapleader = ','

" Wrapped lines goes down/up to next row, rather than next line in file.
nnoremap j gj
nnoremap k gk

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

"clearing highlighted search
nmap <silent> <leader>/ :nohlsearch<CR>

" Shortcuts
" Change Working Directory to that of the current file
cmap cd. lcd %:p:h

" visual shifting (does not exit Visual mode)
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
map <Leader>= <C-w>=
map <Leader>gr :GoldenRatioResize<CR>

" Format XML files
map <Leader>xml :silent 1,$!xmllint --format --recover - 2>/dev/null

" Insert current timestamp (http://vim.wikia.com/wiki/Insert_current_date_or_time)
:nnoremap <F5> "=strftime("%c")<CR>P
:inoremap <F5> <C-R>=strftime("%c")<CR>

" Fix syntax highlighting
:map <Leader>fixsyn :syntax sync fromstart<CR>
:nnoremap <F6> :syntax sync fromstart<CR>
:inoremap <F6> :syntax sync fromstart<CR>

" }

" Plugins {

" Ack.vim {
let g:ackprg="ag"
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
let NERDTreeShowHidden=1
let NERDTreeKeepTreeInNewTab=1
let NERDTreeWinSize=50
" }

" Fugitive {
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gl :Glog<CR>
nnoremap <silent> <leader>gp :Git push<CR>
" }

" OmniComplete {
if has("autocmd") && exists("+omnifunc")
	autocmd Filetype *
				\if &omnifunc == "" |
				\setlocal omnifunc=syntaxcomplete#Complete |
				\endif
endif

hi Pmenu  guifg=#000000 guibg=#F8F8F8 ctermfg=black ctermbg=Lightgray
hi PmenuSbar  guifg=#8A95A7 guibg=#F8F8F8 gui=NONE ctermfg=darkcyan ctermbg=lightgray cterm=NONE
hi PmenuThumb  guifg=#F8F8F8 guibg=#8A95A7 gui=NONE ctermfg=lightgray ctermbg=darkcyan cterm=NONE

" some convenient mappings
inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <C-d>      pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
inoremap <expr> <C-u>      pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"

" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menu,preview,longest
" }

" Ctags {
set tags=./tags;/,~/.vimtags
" }

" EasyTags {
let g:easytags_cmd = 'ctags'
" }

" AutoCloseTag {
" Make it so AutoCloseTag works for xml and xhtml files as well
au FileType xhtml,xml ru ftplugin/html_autoclosetag.vim
nmap <Leader>ac <Plug>ToggleAutoCloseMappings
" }

" TagBar {
nnoremap <silent> <leader>tt :TagbarToggle<CR>
"}
" }

" GUI Settings {
" GVIM- (here instead of .gvimrc)
if has('gui_running')
	"colorscheme ir_dark
	"colorscheme wombat
	"colorscheme Tomorrow-Night-Eighties
	colorscheme badwolf
	"colorscheme kellys

	"set guioptions-=T           " remove the toolbar
	set lines=60                " 50 lines of text instead of 24,
	set columns=200
	"set guifont=Andale\ Mono\ Regular:h16,Menlo\ Regular:h15,Consolas\ Regular:h16,Courier\ New\ Regular:h18
	if has('gui_macvim')
		"	set transparency=5          " Make the window slightly transparent
	endif
else
	colorscheme default
	set term=builtin_ansi       " Make arrow and other keys work
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

function! NERDTreeInitAsNeeded()
	redir => bufoutput
	buffers!
	redir END
	let idx = stridx(bufoutput, "NERD_tree")
	if idx > -1
		NERDTreeMirror
		NERDTreeFind
		wincmd l
	endif
endfunction
" }

" Use local vimrc if available {
if filereadable(expand("~/.vimrc.local"))
	source ~/.vimrc.local
endif
" }

" Use local gvimrc if available and gui is running {
if has('gui_running') 
	if filereadable(expand("~/.gvimrc.local")) 
		source ~/.gvimrc.local
	endif
endif
" }

