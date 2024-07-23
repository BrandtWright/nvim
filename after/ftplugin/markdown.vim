setlocal nofoldenable
setlocal shiftwidth=2
setlocal tabstop=2
setlocal expandtab
setlocal nowrap
setlocal spell
setlocal formatexpr=markdown#format()

function! ConvertMarkdownToHTMLAndOpen()
    " Define a temporary file path
    let l:tmp_html = tempname() . '.html'
    " Write html to the temporary file
    silent execute 'w !pandoc -s -f commonmark -t html -V colorlinks=true >| ' . l:tmp_html
    " Open the temporary file
    silent execute '!xdg-open' l:tmp_html
endfunction

nnoremap <buffer> <leader>mp :w !pandoc -s -f commonmark -t pdf -V colorlinks=true \| zathura - &<cr>
nnoremap <buffer> <leader>mh :call ConvertMarkdownToHTMLAndOpen()<cr>

"Moved to plugins/ui.lua
lua vim.b.miniindentscope_disable = true

augroup MarkdownFilters
autocmd BufWritePre *.md silent :ToEmoji
"autocmd BufEnter *.md :syntax match mkdBullet /\(^\s*\)\@<=[*]/ conceal cchar=●
augroup END
