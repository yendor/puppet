if has("autocmd")
	filetype on
	filetype indent on
	filetype plugin on
endif

" Colourisation settings
syntax enable
set bg=dark

"Set tabs to look like 4 spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

set backspace=eol,start,indent
set nobackup

" Search options
set nohlsearch
set wrapscan
set ignorecase

" set noautoindent
set showmatch

set title

" Make filename completion in command mode behave like bash
set wildmode=longest:full
set wildmenu

" Highlight trailing whitespace
hi WhiteSpaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+\%#\@<!$/

" Remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" Editor interface options
set ruler
set laststatus=2
set showcmd
set number
set showtabline=2
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\[HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]

" Command to force a write using sudo
command W w !sudo tee % > /dev/null

let pascal_delphi=1

let php_sql_query = 1
let php_htmlInStrings = 1
