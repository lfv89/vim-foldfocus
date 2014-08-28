" ---------------------------------------------------------------------
" Utility functions to handle the vim windows. I got this code from
" this awesome lib: http://www.vim.org/scripts/script.php?script_id=197
" ---------------------------------------------------------------------

function! FindBufferForName(fileName)
  return s:FindBufferForName(a:fileName)
endfunction

function! s:FindBufferForName(fileName)
  let fileName = a:fileName
  let _isf = &isfname
  try
    set isfname-=\
    set isfname-=[
    let i = bufnr('^' . fileName . '$')
  finally
    let &isfname = _isf
  endtry

  return
endfunction

let s:notifyWindow = {}

function! AddNotifyWindowClose(windowTitle, functionName)
  let bufName = a:windowTitle

  let s:notifyWindow[bufName] = a:functionName

  " Start listening to events.
  aug NotifyWindowClose
    au!
    au WinEnter * :call CheckWindowClose()
    au BufEnter * :call CheckWindowClose()
  aug END
endfunction

function! RemoveNotifyWindowClose(windowTitle)
  let bufName = a:windowTitle

  if has_key(s:notifyWindow, bufName)
    call remove(s:notifyWindow, bufName)
    if len(s:notifyWindow) == 0
      "unlet g:notifyWindow " Debug.

      aug NotifyWindowClose
        au!
      aug END
    endif
  endif
endfunction

function! CheckWindowClose()
  if !exists('s:notifyWindow')
    return
  endif

  for nextWin in keys(s:notifyWindow)
    if bufwinnr(s:FindBufferForName(nextWin)) == -1
      let funcName = s:notifyWindow[nextWin]
      unlet s:notifyWindow[nextWin]
      "call input("cmd: " . cmd)
      call call(funcName, [nextWin])
    endif
  endfor
endfunction

" -------------------
" FoldFocus functions
" -------------------

let s:foldFocus = {}

function! FoldFocus(bufferFunction)
  let myFiletype      = &filetype
  let tmpBufferName   = 'FoldFocus'
  let tmpBufferWindow = bufwinnr('^' . tmpBufferName . '$')

  let originalBuffer = bufname(0)
  let s:foldFocus['originalBufferWindow'] = bufwinnr(originalBuffer)

  let s:foldFocus['foldStart'] = line('.')

  if (foldclosed(s:foldFocus['foldStart']) == -1)
    echo 'This is not a closed fold!'
  else
    silent! normal! zo
    silent! normal! zc
    silent! normal! k3yy

    if (tmpBufferWindow >= 0)
        execute tmpBufferWindow . 'wincmd w'
        silent! normal! gg"_dG
    else
        execute a:bufferFunction . ' ' . tmpBufferName

        setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap

        if (a:bufferFunction == 'e')
          nnoremap <buffer> q :bp<cr>
        endif

        call AddNotifyWindowClose(tmpBufferName, 'PasteFocusContent')
        au QuitPre,BufDelete,BufUnload FoldFocus call CopyFocusContent()
    endif

    execute 'set filetype=' . myFiletype

    silent! normal! p
    silent! normal! ggdd
    silent! normal! zR
  endif
endfunction

function! PasteFocusContent(windowTitle)
  execute s:foldFocus['originalBufferWindow'] . 'wincmd w'
  execute s:foldFocus['foldStart']

  normal! k3"_dd
  normal! k
  normal! p
  silent! normal! jzc

  execute 'w'

  call RemoveNotifyWindowClose(a:windowTitle)
  au! QuitPre,BufDelete,BufUnload FoldFocus
endfunction

function! CopyFocusContent()
  normal! ggyG
endfunction
