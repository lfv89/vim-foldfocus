function! FoldFocus()
  let my_filetype = &filetype
  let winnr = bufwinnr('^FoldFocus$')

  silent! normal! zc
  silent! normal! k3yy

  if (winnr >= 0)
      execute winnr . 'wincmd w'
      set modifiable
      silent! normal! gg"_dG
  else
      set modifiable
      setlocal splitright
      vnew FoldFocus

      setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  endif

  execute 'set filetype=' . my_filetype

  silent! normal! p
  silent! normal! ggdd
  silent! normal! gg=G
  silent! normal! zR

  set nomodifiable
endfunction
