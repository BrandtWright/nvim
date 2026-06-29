" Recursive nmap (not nnoremap) on purpose: the RHS `-` and `<cr>` are netrw's
" own buffer-local mappings (go up a dir / open), so they must be allowed to
" expand. nnoremap would bind to the literal keys and break navigation.
nmap <buffer> h -
nmap <buffer> l <cr>
