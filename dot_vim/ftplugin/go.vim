set noexpandtab
nmap gd <Plug>(go-def)
nmap gn <Plug>(go-def-tab)
nmap gD <Plug>(go-def-pop)
nmap gb <Plug>(go-build)
nmap gt <Plug>(go-test)
nmap gr <Plug>(go-rename)
nmap ga :GoAlternate<CR>

let g:ale_go_golangci_lint_package = 1
let g:ale_go_golangci_lint_options = '--fast'
let g:go_test_timeout = '60s'
let g:go_def_mapping_enabled = 0
let g:go_highlight_space_tab_error = 1
let g:go_list_autoclose = 1
let g:go_list_type = 'quickfix'
let g:go_alternate_mode = 'tabedit'
let g:go_fmt_command = 'goimports'
