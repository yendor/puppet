syntax on
set shiftwidth=4
set tabstop=4
set background=dark

set title

" Setting this enables the completion list to popup
set dictionary=/usr/share/dict/words

" Highlight trailing whitespace
hi WhiteSpaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+\%#\@<!$/

" Remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

autocmd FileType python set tabstop=4|set shiftwidth=4|set expandtab

