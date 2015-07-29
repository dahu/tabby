" Fix the non-orthogonal behaviour of gt vs gT

" gt now moves forward [count] number of tabs (default 1)
" (so,   3gt   moves forward 3 tabs)

" gT retains its default behaviour of moving backward [count] tabs

" a new <leader>gt map replaces the old gt behaviour of jumping to a tab by
" number (so,   3<leader>gt   moves to tab 3)

" <leader>T jumps to the alternate tab. This allows quick
" switching between current tabs like ctrl-6 switched between current buffers.

function! TabForward(nr)
  let lastpage = tabpagenr('$')
  let newpage = (tabpagenr() + a:nr) % lastpage
  let newpage = newpage == 0 ? lastpage : newpage
  exe "tabn " . newpage
endfunction

" Preserves current tab and window numbers
let g:tabalt = 1
let g:winalt = 1
function! TabAltSet()
  let g:tabalt = tabpagenr()
  let g:winalt = winnr()
endfunction

" If a positive count is provided, jump to that tab number
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

" Maps {{{1
nnoremap gt           :<c-u>call TabForward(v:count1)<cr>
nnoremap <leader>gt   gt
nnoremap <leader>T    :<c-u>call TabAlt(v:count)<cr>
