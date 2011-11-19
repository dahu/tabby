" Fix the non-orthogonal behaviour of gt vs gT
" gt now moves forward [count] number of tabs (default 1)
" (so,   3gt   moves forward 3 tabs)
" gT retains its default behaviour of moving backward [count] tabs
" a new Gt map replaces the old gt behaviour of jumping to a tab by number
" (so,   3Gt   moves to tab 3)
function! TabForward(nr)
  let lastpage = tabpagenr('$')
  let newpage = (tabpagenr() + a:nr) % lastpage
  let newpage = newpage == 0 ? lastpage : newpage
  exe "tabn " . newpage
endfunction

nnoremap gt :<C-U>call TabForward(v:count1)<CR>
nnoremap gn :<C-U>exe "tabn " . v:count<CR>

" Preserves current tab and window numbers
let g:tabalt = 1
let g:winalt = 1
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

augroup  Tabby
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
