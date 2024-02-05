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
