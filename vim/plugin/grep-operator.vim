nnoremap <Leader>g :set operatorfunc=<SID>GrepOperator<cr>g@
vnoremap <Leader>g :<c-u>call <SID>GrepOperator(visualmode())<cr>

function! s:GrepOperator(type)
    let saved_unnamed_register = @@

    if a:type ==# 'v'
        normal! `<v`>y
    elseif a:type ==# 'char'
        normal! `[v`]y
    else
        return
    endif

    silent execute "grep! " . shellescape(@@) . " ."
    copen

    let @@ = saved_unnamed_register
endfunction
