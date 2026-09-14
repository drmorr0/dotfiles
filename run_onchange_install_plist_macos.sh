#!/bin/sh
launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/local.kube-tmux.plist
launchctl kickstart -k gui/$(id -u)/local.kube-tmux
