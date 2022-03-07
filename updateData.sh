#!/bin/bash
cp ~/.config/Code/User/snippets/log.code-snippets ./code/snippets/js/log.code-snippets
cp ~/.config/Code/User/keybindings.json ./code/shortcuts/keybindings.json

dconf dump /org/gnome/settings-daemon/plugins/media-keys/ > dump_keybindings