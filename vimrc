
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

" }

" Vundle {

" Setup Vundle Support {
" The next two lines ensure that the ~/.vim/bundle/ system works
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" }

Plugin 'gmarik/Vundle.vim'

" Color schemes
Plugin 'chriskempson/vim-tomorrow-theme'
Plugin 'sjl/badwolf'
Plugin 'kellys'
Plugin 'nanotech/jellybeans.vim'
Plugin 'vim-scripts/Wombat'
Plugin 'chriskempson/base16-vim'
Plugin 'tomasr/molokai'

" General
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'bufexplorer.zip'
Plugin 'delimitMate.vim'
Plugin 'roman/golden-ratio'
Plugin 'rking/ag.vim'
Plugin 'bling/vim-airline'
Plugin 'rizzatti/dash.vim'
Plugin 'yssl/QFEnter'

" Development
Plugin 'tpope/vim-git'
Plugin 'tpope/vim-fugitive'
Plugin 'vcscommand.vim'
Plugin 'scrooloose/syntastic'
Plugin 'majutsushi/tagbar'
Plugin 'Shougo/neocomplcache'
Plugin 'matchit.zip'
"Plugin 'SirVer/ultisnips'
Plugin 'kien/ctrlp.vim'
Plugin 'airblade/vim-rooter'
Plugin 'airblade/vim-gitgutter'
Plugin 'joonty/vdebug'

" HTML
Plugin 'othree/html5.vim'
Plugin 'vim-scripts/HTML-AutoCloseTag'
Plugin 'tpope/vim-ragtag'

" PHP
Plugin 'spf13/PIV'
Plugin 'joonty/vim-phpqa'

" HAML/Sass/SCSS - I mostly care about Sass/SCSS
Plugin 'tpope/vim-haml'

" Ruby
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rails'
Plugin 'ruby-matchit'

" API Blueprint (Apiary)
Plugin 'kylef/apiblueprint.vim'

" Other
Plugin 'elzr/vim-json'

" Finish setting up Vundle support {
" Must go after "Plugin" lines
call vundle#end()
" }

" }

" General {
filetype plugin indent on   " Automatically detect file types.
syntax on                   " syntax highlighting
set mouse=a                 " automatically enable mouse usage
scriptencoding utf-8

set shortmess+=filmnrxoOtTF      " abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash " better unix / windows compatibility
set virtualedit=onemore         " allow for cursor beyond last character
set history=1000                " Store a ton of history (default is 20)
set hidden                      " allow buffer switching without saving

set nobackup " Don't create annoying backup files
set noswapfile " Swap files? Meh.

"if has('syntax')
	"set spelllang=en_us " Set spelling language
"endif

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

	" Broken down into easy-to-include segments
	set statusline=                            " empty line to facilitate easy moving around of segments
	set statusline+=%W%H%M%R                   " Options
	"set statusline+=\ %<%f\  "
	set statusline+=\ %<%t\  "
	set statusline+=\ [%{getcwd()}]            " Current directory
	set statusline+=\ %{fugitive#statusline()} " Git Info
	set statusline+=\ [%{&ff}/%Y]              " Filetype
	set statusline+=%=                         " split between left- and right-aligned info"
	set statusline+=%-8.(%l,%c%V%)\ %p%%       " file nav info
endif

set backspace=indent,eol,start  " backspace for dummies
set linespace=1                 " Extra pixels between rows
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
set list                        " Show list characters (tab, EOL, etc as set in listchars)
set listchars=tab:,.,trail:.,extends:#,precedes:#,nbsp:. " Show potentially-problematic whitespace
set splitright                  " New splits to the right
set splitbelow                  " New splits below
" }

" Formatting {
set nowrap                       " wrap long lines
set autoindent                   " indent at the same level of the previous line
set shiftwidth=4                 " use indents of 4 spaces
set noexpandtab                  " tabs are tabs, damnit!
set tabstop=4                    " an indentation every four columns
set softtabstop=4                " let backspace delete indent
"set matchpairs+=<:>              " match, to be used with %
set pastetoggle=<F12>            " pastetoggle (sane indentation on pastes)
"set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks

" Remove trailing whitespaces and ^M chars
"autocmd FileType c,cpp,java,php,js,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

" Keep syntax in sync (hopefully this isn't too slow)
autocmd BufEnter * :syntax sync fromstart

let g:PHP_vintage_case_default_indent = 1
" }

" Filetype-specific settings {
"autocmd FileType c,cpp,java,php,js,python,twig,xml,yml set formatoptions-=t
autocmd FileType python setlocal noexpandtab
autocmd FileType php setlocal expandtab
autocmd FileType ruby,eruby setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
autocmd FileType markdown setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
"au FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"

augroup filetypedetect
	"autocmd BufNew,BufNewFile,BufRead *.txt,*.text,*.md,*.markdown :setfiletype markdown
	autocmd BufNew,BufNewFile,BufRead *.md,*.mkdn,*.markdown :set filetype=markdown
	autocmd BufNew,BufNewFile,BufRead *.module :set filetype=php " Drupal module
	autocmd BufNew,BufNewFile,BufRead *.sls :set filetype=yaml " Salt state files
augroup END

" }

" Key (re)Mappings {

"The default leader is '\', but many people prefer ',' as it's in a standard
"location
let mapleader = ','

map <leader>s :w<CR>

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
map <Leader>_ <C-w>_
map <Leader>= <C-w>=
map <Leader>gr :GoldenRatioResize<CR>

" Format XML files
map <Leader>xml :silent 1,$!xmllint --format --recover - 2>/dev/null

" Format JSON files
nmap <leader>json :%!jsonlint<CR>

" Convert Markdown to HTML
nmap <leader>md :%!multimarkdown<CR>

" Insert current timestamp (http://vim.wikia.com/wiki/Insert_current_date_or_time)
:nnoremap <leader>dts "=strftime("%c")<CR>PA

" Fix syntax highlighting
map <leader>syn :syntax sync fromstart<CR>

" }

" Plugins {

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
nnoremap <silent> <leader>to :TagbarOpen jf<CR>
"}

" Ctrl-P {
let g:ctrlp_working_path_mode = 'ra'
"}

" Airline {
let g:airline_powerline_fonts = 1
let g:airline#extensions#whitespace#mixed_indent_algo = 1
" }

" Rooter {
let g:rooter_use_lcd = 1 " Use local :lcd instead of :cd
let g:rooter_patterns = ['.git/', '.git', '.hg/', '._darcs/', '.bzr/', '.svn/']
map <silent> <unique> <Leader>pcd <Plug>RooterChangeToRootDirectory
" }

" PHPQA {
let g:phpqa_messdetector_autorun = 0
let g:phpqa_open_loc = 0 " Don't open location list by default
" }

" Vdebug {
if !exists('g:vdebug_options')
  let g:vdebug_options = {}
endif
let g:vdebug_options['path_maps'] = { '/src': $HOME . '/Sites' }
" }

" }

" GUI Settings {
" GVIM- (here instead of .gvimrc)
if has('gui_running')
	"colorscheme ir_dark
	"colorscheme wombat
	"colorscheme Tomorrow-Night-Eighties
	colorscheme Tomorrow-Night
	"colorscheme badwolf
	"colorscheme kellys
	"colorscheme jellybeans
	"colorscheme base16-tomorrow

	"set guioptions-=T           " remove the toolbar
	set lines=60                " Set a more appropriate number of lines
	set columns=200             " Set a more appropriate number of columns
	set guifont=Hack:h15,Anonymous\ Pro\ for\ Powerline:h14,Anonymous\ Pro:h14,Menlo\ Regular:h15,Andale\ Mono\ Regular:h16,Consolas\ Regular:h16,Courier\ New\ Regular:h18
	if has('gui_macvim')
		"	set transparency=5          " Make the window slightly transparent
	endif
else
	colorscheme default
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

