" Clears hlsearch after doing a search, otherwise just does normal <CR> stuff
" nnoremap <expr> <CR> {-> v:hlsearch ? ":nohl\<CR>" : "\<CR>"}()
" Find and replace (buffer-wide)
nnoremap <leader><leader>r mz:%s/\<<C-r><C-w>\>/
