syntax on

set shiftwidth=2 tabstop=2 autoindent cindent expandtab

" search
set hlsearch
set incsearch
highlight Search term=bold cterm=NONE ctermfg=White ctermbg=DarkYellow gui=NONE guifg=DarkGrey guibg=NONE

" line number
set number
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
nmap <C-N><C-N> :set invnumber<CR>
set cursorline
highlight CursorLine   cterm=NONE ctermbg=17 ctermfg=NONE guibg=17 guifg=NONE
" highlight Pmenu ctermfg=16 ctermbg=DarkBlue guibg=Red
