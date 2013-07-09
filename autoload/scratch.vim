function! scratch#MarkScratchBuffer(type)
  execute "setlocal filetype=" . a:type
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  setlocal buflisted
endfunction

function! scratch#OpenScratchBuffer(forceSplitWin, vert, ...)
  let bunName = "__SCRATCH__" . bufnr('%')
  if len(a:000)
    let bufName = a:000[0]
  endif

  let bufType = exists("b:scratch_buffer_type") ? b:scratch_buffer_type : &filetype
  if len(a:000) > 1
    let bufType = a:000[1]
  endif

  " force open in a split if buffer is modified and hidden buffers aren't allowed
  let splitWin = a:forceSplitWin
  if !splitWin && !&hidden && &modified
    let splitWin = 1
  endif

  let bufNum = bufnr(bufName)
  if bufNum ==# -1
    " open a new buffer if it doesn't already exist
    if splitWin
      let command = "new +call\\ scratch#MarkScratchBuffer(\"" . bufType . "\") " . bufName
    else
      let command = "edit " . bufName
    endif
  else
    " scratch buffer already exists... open it
    if splitWin
      let command = "split +buffer" . bufNum
    else
      let command = "buffer " . bufNum
    endif
  endif 

  if a:vert
    execute "vert " . command
  else
    execute command
  endif
endfunction
