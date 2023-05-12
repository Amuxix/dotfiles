#!/bin/bash

DOTFILES="$(pwd)"

files=(".zshrc" ".p10k.zsh" ".config/nvim")

for file in "$files[@]"
do
  f="$HOME/$file"
  if [[ -d f ]] || [[ -f f ]] && ! [[ -L f ]]; then
    echo "$file already exists, move it to old/?"
    mv -i f old/
  fi
  ln -df "$DOTFILES/$file"
done
