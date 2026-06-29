setlocal nofoldenable
setlocal shiftwidth=2
setlocal tabstop=2
setlocal expandtab
setlocal nowrap
setlocal spell
setlocal formatexpr=markdown#format()

" Defined once, not redefined on every markdown buffer load. (This ftplugin is
" re-sourced per markdown buffer; the guard skips the redundant redefinition.)
if !exists('*ConvertMarkdownToHTMLAndOpen')
    function ConvertMarkdownToHTMLAndOpen()
        " Define a temporary file path
        let l:tmp_html = tempname() . '.html'
        " Write html to the temporary file
        silent execute 'w !pandoc -s -f commonmark -t html -V colorlinks=true >| ' . l:tmp_html
        " Open the temporary file
        silent execute '!xdg-open' l:tmp_html
    endfunction
endif

nnoremap <buffer> <leader>mp :w !pandoc -s -f commonmark -t pdf -V colorlinks=true \| zathura - &<cr>
nnoremap <buffer> <leader>mh :call ConvertMarkdownToHTMLAndOpen()<cr>
