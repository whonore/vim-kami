function! s:checkKami() abort
  let l:maxlines = 50
  let l:kwds = ['ARRAY', 'STRUCT', 'MODULE', 'Register', 'Rule', 'Method']
  let l:pat = printf('\(%s\)', join(l:kwds, '\|'))

  if &filetype !=# 'coq'
    return
  endif

  for l:lnum in range(1, l:maxlines)
    if getline(l:lnum) =~# l:pat
      set filetype=coq.kami
      break
    endif
  endfor
endfunction

au BufRead,BufNewFile *.v call s:checkKami()
