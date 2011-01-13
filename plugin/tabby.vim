" Preserves current tab and window numbers
function! TabAltSet()
  let g:tabalt = tabpagenr()
  let g:winalt = winnr()
endfunction

" If a count is provided, jump to that tab number
" otherwise, jump to the alternate tab.
" Restores window position too.
function! TabAlt(tabnum)
  if a:tabnum
    exe ":tabn ".a:tabnum
  else
    exe "tabn ".g:tabalt
    exe "normal ".g:winalt."<c-w>w"
  endif
endfunction

augroup  Tabs
  au!
  au TabLeave * call TabAltSet()
augroup END

" Always open :help pages in leftmost tab
cabbr help tabn 1 <bar> help
" NOTE: :h unafected for local tab help pages

" map [count]<C-End> to TabAlt(count)
nnoremap <C-End> :<C-U>call TabAlt(v:count)<CR>
" map [count]<C-Home> to :tabn <count>
nnoremap <C-Home> :<C-U>exe ":tabn ".v:count1<CR>
" NOTE: 1<C-End> == 1<C-Home> == <C-Home>

nnoremap <C-PageDown> :tabn<CR>
nnoremap <C-PageUp> :tabp<CR>
