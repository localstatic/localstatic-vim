
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

" General {
filetype plugin indent on   " Automatically detect file types.
syntax on                   " syntax highlighting
set mouse=a                 " automatically enable mouse usage
scriptencoding utf-8

set shortmess+=filmnrxoOtT "F      " abbrev. of messages (avoids 'hit enter')
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
	"set statusline+=\ %{fugitive#statusline()} " Git Info
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

" Keep syntax in sync (hopefully this isn't too slow)
autocmd BufEnter * :syntax sync fromstart

let g:PHP_vintage_case_default_indent = 1
" }

" Filetype-specific settings {
"autocmd FileType c,cpp,java,php,js,ts,python,twig,xml,yml set formatoptions-=t
autocmd FileType python setlocal noexpandtab
autocmd FileType php setlocal expandtab
autocmd FileType ruby,eruby setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
autocmd FileType markdown setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
autocmd FileType javascript,typescript setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
autocmd FileType html,xhtml setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
"au FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"

augroup filetypedetect
	autocmd BufNew,BufNewFile,BufRead *.md,*.mkdn,*.markdown :set filetype=markdown
	autocmd BufNew,BufNewFile,BufRead *.module :set filetype=php " Drupal module
	autocmd BufNew,BufNewFile,BufRead *.sls :set filetype=yaml " Salt state files
	autocmd BufNew,BufNewFile,BufRead *.ts :set filetype=typescript
augroup END

" }

" Key (re)Mappings {

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
"map <Leader>gr :GoldenRatioResize<CR>

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

" Trim trailing whitespace
map <Leader>trail :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))<CR>

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

