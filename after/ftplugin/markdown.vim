setlocal nofoldenable
setlocal shiftwidth=2
setlocal tabstop=2
setlocal expandtab
setlocal nowrap
setlocal spell
" Wrap prose at 80 columns, both while typing (the runtime markdown ftplugin
" adds 't' to formatoptions) and with gq. Matches markdownlint's MD013 limit.
setlocal textwidth=80
setlocal colorcolumn=81
" LazyVim's global formatexpr routes gq to conform, whose markdown formatter
" (markdownlint-cli2) fixes style but never reflows. Empty restores Vim's
" built-in reflow for gq; style fixes still happen on save.
setlocal formatexpr=

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
