let g:ale_virtualtext_cursor=0
let g:ale_cursor_detail=1
let g:ale_floating_preview=1
let g:ale_floating_window_border=['│', '─', '╭', '╮', '╯', '╰', '│', '─']
let g:ale_echo_delay=1000
let g:ale_rust_rustfmt_options = '+nightly --unstable-features --edition 2021'
let g:ale_rust_analyzer_config = {'cargo': {'extraArgs': ['--target-dir', '/home/drmorr/.cache/rust-analyzer'], 'features': 'all'}}
nmap gd :ALEGoToDefinition<CR>
nmap gr :ALERename<CR>
