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

if $TERM == 'rxvt-unicode'
  " I don't like the <leader> form as much...
  "nnoremap <leader><c-^> :call TabAlt()<CR>
  " map [count]<C-End> to TabAlt(count)
  nnoremap <Esc>[8^ :<C-U>call TabAlt(v:count)<CR>
  " map [count]<C-Home> to :tabn <count>
  nnoremap <Esc>[7^ :<C-U>exe ":tabn ".v:count1<CR>
  " NOTE: 1<C-End> == 1<C-Home> == <C-Home>

  " rxvt-unicode doesn't handle <C-PageDown> and <C-PageUp>
  nnoremap <Esc>[6^ :tabn<CR>
  nnoremap <Esc>[5^ :tabp<CR>

  " window maps for rxvt-unicode <C-Up> <C-Down> <C-Left> <C-Right>
  nnoremap <Esc>Oa <c-w>k
  nnoremap <Esc>Ob <c-w>j
  nnoremap <Esc>Oc <c-w>l
  nnoremap <Esc>Od <c-w>h
else
  " map [count]<C-End> to TabAlt(count)
  nnoremap <C-End> :<C-U>call TabAlt(v:count)<CR>
  " map [count]<C-Home> to :tabn <count>
  nnoremap <C-Home> :<C-U>exe ":tabn ".v:count1<CR>
  " NOTE: 1<C-End> == 1<C-Home> == <C-Home>

  " rxvt-unicode doesn't handle <C-PageDown> and <C-PageUp>
  nnoremap <C-PageDown> :tabn<CR>
  nnoremap <C-PageUp> :tabp<CR>
endif
