function! s:checkKami() abort
  let l:maxlines = 50
  let l:kwds = ['ARRAY', 'STRUCT', 'MODULE', 'Register', 'Rule', 'Method']
  let l:pat = printf('\(%s\)', join(l:kwds, '\|'))

  for l:vars in [b:, g:]
    if get(l:vars, 'coq_kami_disable', 0)
      return
    endif
  endfor

  if join(getline(1, l:maxlines), ' ') =~# l:pat
    setlocal filetype=coq.kami
  endif
endfunction

au BufRead,BufNewFile *.v call s:checkKami()
