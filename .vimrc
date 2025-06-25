
syntax on
filetype plugin on
filetype indent on

set backspace=eol,start,indent
set nocompatible
set nobackup
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=120
set nohlsearch
set wildmode=longest,list,full
set wildmenu
set number
set autoread

au CursorHold,CursorHoldI * checktime
au FocusGained,BufEnter * checktime

" return to the last place you were editing
autocmd BufReadPost * silent! normal! g`"zv

" Persistent undo
set undofile
set undodir=/home/drmorr/.vim/undo/
set undolevels=10000

" Folding options {{{
autocmd BufRead .vimrc setlocal foldmethod=marker
autocmd BufRead .vimrc normal zM
autocmd BufRead Dockerfile* setlocal foldmethod=marker
autocmd BufRead Dockerfile* normal zM
" }}}

" Disable word wrap, make scrolling more sensible {{{
set nowrap
set sidescroll=5
set listchars+=precedes:<,extends:>
highlight OverLength cterm=underline
match OverLength /\%121v.\+/
" }}}

" Custom commands {{{
nnoremap <c-t> :tabnew<cr>

set pastetoggle=<F4>

function ToggleWidth()
    let g:tw = &textwidth
    if (g:tw == 120)
        set textwidth=0
        highlight OverLength cterm=none
    else
        set textwidth=120
        highlight OverLength cterm=underline
    endif
endfunction
nnoremap <F5> :call ToggleWidth() <cr>

cmap w!! w !sudo tee > /dev/null %

function s:ReplaceAll_Helper(to_find, replace_with)
    exec "bufdo %s/" . a:to_find . "/" . a:replace_with . "/ge | update"
endfunction
command -nargs=+ ReplaceAll call s:ReplaceAll_Helper(<f-args>)
" }}}

" Colors {{{
hi SpellBad cterm=underline ctermfg=red ctermbg=0
hi SpellCap ctermbg=None

hi MatchParen cterm=bold ctermbg=none ctermfg=red

hi SignColumn ctermbg=7
hi DiffAdd cterm=bold ctermbg=7 ctermfg=yellow
hi DiffDelete cterm=bold ctermbg=7 ctermfg=yellow
hi DiffChange cterm=bold ctermbg=7 ctermfg=yellow
hi DiffText cterm=bold ctermbg=7 ctermfg=yellow

hi ALEVirtualTextError cterm=underline ctermfg=1
hi ALEVirtualTextWarning cterm=underline ctermfg=2
hi Pmenu ctermbg=1

hi Constant ctermfg=105
hi! link SpecialComment Comment
" }}}

" {{{ Plugin configuration

  " fzf {{{
    nnoremap <c-P> :Files<cr>
    nnoremap <c-H> :Rg<cr>
    if exists('$TMUX')
      let g:fzf_layout = { 'tmux': '90%,70%' }
    else
      let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
    endif
  " }}}

  " ale {{{
    let g:ale_set_highlights = 0
    let g:ale_sign_column_always = 1
    let g:ale_set_loclist = 0

    " ruff calls `ruff check --fix` whereas ruff_format calls `ruff format`
    let g:ale_fixers = {
                \ '*': ['remove_trailing_lines', 'trim_whitespace'],
                \ 'rust': ['rustfmt'],
                \ 'python': ['remove_trailing_lines', 'trim_whitespace', 'ruff', 'ruff_format'],
                \ }
    " note that linters just show error messages inline, fixers actually fix things on save
    let g:ale_linters = {'python': ['ruff'], 'rust': ['analyzer']}
    let g:ale_fix_on_save = 1
  " }}}

  " airline {{{
    let g:airline_theme = 'solarized'
    let g:airline_powerline_fonts = 1
    let g:airline_skip_empty_sections = 1
    let g:airline#extensions#hunks#hunk_symbols = ['+', '*', '-']
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#show_tab_nr = 1
    let g:airline#extensions#tabline#show_tab_type = 0
    let g:airline#extensions#tabline#tab_nr_type = 1
    let g:airline#extensions#tabline#left_sep = ' '
    let g:airline#extensions#tabline#left_alt_sep = '|'
    let g:airline#extensions#tabline#show_close_button = 0
    let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
    let g:airline#extensions#tabline#show_splits = 0
    let g:airline#extensions#virtualenv#enabled = 0
    let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'

    nmap <leader>1 <Plug>AirlineSelectTab1
    nmap <leader>2 <Plug>AirlineSelectTab2
    nmap <leader>3 <Plug>AirlineSelectTab3
    nmap <leader>4 <Plug>AirlineSelectTab4
    nmap <leader>5 <Plug>AirlineSelectTab5
    nmap <leader>6 <Plug>AirlineSelectTab6
    nmap <leader>7 <Plug>AirlineSelectTab7
    nmap <leader>8 <Plug>AirlineSelectTab8
    nmap <leader>9 <Plug>AirlineSelectTab9
    nmap <leader>- <Plug>AirlineSelectPrevTab
    nmap <leader>+ <Plug>AirlineSelectNextTab

    function! AirlineInit()
        let g:airline_section_b = airline#section#create(['%p%% (%l/%L) : %c'])
        let g:airline_section_a = airline#section#create(['branch', ' ', 'hunks'])
        let g:airline_section_c = ' '
        let g:airline_section_x = ''
        let g:airline_section_z = ''
    endfunction
    autocmd User AirlineAfterInit call AirlineInit()
  " }}}

  " gitgutter {{{
    let g:gitgutter_sign_modified = '*'
    let g:gitgutter_sign_modified_removed = '*-'
    let g:gitgutter_sign_removed = '-'

    hi def link GitGutterAdd DiffAdd
    hi def link GitGutterDelete DiffDelete
    hi def link GitGutterChange DiffChange
  " }}}

  " localvimrc {{{
    let g:localvimrc_persistent = 2
  " }}}

  " ArgWrap {{{
    let g:argwrap_tail_comma = 1
    nmap <F2> :ArgWrap<CR>
  " }}}

  " vim-qf {{{
    nmap ]a <Plug>(qf_qf_previous)
    nmap [a <Plug>(qf_qf_next)
    nmap <F3> <Plug>(qf_qf_toggle_stay)
  " }}}

  " vimtex {{{
    let g:vimtex_view_method = 'zathura'
    let g:vimtex_quickfix_enabled = 0
  " }}}

    " surround {{{
    nmap <leader>` ysiW`
    nmap <leader>] ysiW]
    nmap <leader>_ ysiW_
    nmap <leader>" ysiW"
    "}}}
" }}}
