#!/bin/sh
# ~/.local/bin/tmux-kube-update
ctx=$(kubectl config current-context 2>/dev/null) || ctx=none
ns=$(kubectl config view --minify -o 'jsonpath={..namespace}' 2>/dev/null)
tmux set -g @kube "#[fg=orange,bold,bg=magenta] ${ctx}#[fg=black,bg=magenta]:#[fg=color15,bold,bg=magenta]${ns:-default} #[default]" 2>/dev/null || exit 0
tmux list-clients -F '#{client_name}' |
  while read -r c; do tmux refresh-client -S -t "$c"; done
