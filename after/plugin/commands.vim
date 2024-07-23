"-------------------------------------------------------------------------------
" ToEmoji
"-------------------------------------------------------------------------------
function! ToEmoji()
    let l:view = winsaveview()
    silent %!toemoji
    call winrestview(l:view)
endfunction
command! ToEmoji call ToEmoji()
