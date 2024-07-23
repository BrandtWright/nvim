setlocal norelativenumber
setlocal nonumber
setlocal scrolloff=0
setlocal nospell
tnoremap <buffer> <C-]> <C-\><C-n>

augroup TermWhitespace
autocmd TermEnter * match InterfacePrimary /\s\+\%#\@<!$/	" Disable whitespace hilights
autocmd TermLeave * match BvimTrailingWhitespace /\s\+\%#\@<!$/	" Highlight trailing whitespace in red
augroup END
