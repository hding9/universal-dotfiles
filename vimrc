syntax enable
set number
set conceallevel=3
set mouse=a
set encoding=UTF-8
set expandtab
set shiftwidth=4
set softtabstop=4
set autoindent
set backspace=indent,eol,start
set scrolloff=999
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" Make the 81st column stand out
highlight ColorColumn ctermbg=magenta
" set colorcolumn=81 " coloring whole 81st column
call matchadd('ColorColumn', '\%81v', 100) " coloring text that reaches 81st only
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Show tabs and trails with symbols
exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
set list
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" swith cursor from block in insert mode
" source: https://gist.github.com/andyfowler/1195581
"if exists('$ITERM_PROFILE')
"  if exists('$TMUX')
"    let &t_SI = "\<Esc>[3 q"
"    let &t_EI = "\<Esc>[0 q"
"  else
"    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
"    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
"    let &t_SR = "\<Esc>]50;CursorShape=2\x7"
"  endif
"end

"Other options (replace the number after \e[):
"    Ps = 0  -> blinking block.
"    Ps = 1  -> blinking block (default).
"    Ps = 2  -> steady block.
"    Ps = 3  -> blinking underline.
"    Ps = 4  -> steady underline.
"    Ps = 5  -> blinking bar (xterm).
"    Ps = 6  -> steady bar (xterm).
"https://stackoverflow.com/questions/6488683/how-do-i-change-the-vim-cursor-in-insert-normal-mode
let &t_SI = "\e[1 q"
let &t_EI = "\e[2 q"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" set highlight color of matched search
hi Search ctermbg=DarkBlue
hi Search ctermfg=Black
" set highlight color of mathed parentheses
hi MatchParen cterm=bold ctermbg=DarkGreen ctermfg=Magenta
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"==========[ Highlight matches when jumping to next ]==========

function! HLNext (blinktime)
    highlight WhiteOnRed ctermfg=White ctermbg=Red
    let [bufnum, lnum, col, off] = getpos('.')
    let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
    let target_pat = '\c\%#\%('.@/.'\)'
    let ring = matchadd('WhiteOnRed', target_pat, 101)
    redraw
    exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
    call matchdelete(ring)
    redraw
endfunction
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" Mapping
imap jj <Esc>
"nnoremap <silent> n   n:call HLNext(0.4)<cr>
"nnoremap <silent> N   N:call HLNext(0.4)<cr>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" plugins
call plug#begin('~/.vim/plugged')
Plug 'dracula/vim', {'as':'dracula'}
"Plug 'vim-airline/vim-airline'
"Plug 'ryanoasis/vim-devicons'
call plug#end()

"color scheme after plugins
"since dracula theme is supported by a plugin
colorscheme elflord
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" cursorline highlight, stop highlight during insert mode
" cursorline highlight should be after colorscheme settings
" otherwise, cursorline would be underline instead of colored background
set cursorline
highlight CursorLine cterm=NONE ctermbg=234 ctermfg=NONE
autocmd InsertEnter * highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE
autocmd InsertLeave * highlight CursorLine cterm=NONE ctermbg=234 ctermfg=NONE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"vim airline settings
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
