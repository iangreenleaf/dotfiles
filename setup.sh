#!/bin/bash

if [ "$1" = "--help" -o "$1" = "help" -o "$1" = "--usage" ]; then
  echo "Usage:"
  echo "$0 [dotfiles_dir] [home_dir]"
  exit
fi

repo=$1
if [ -z "$repo" ]; then
  repo=`pwd`
fi

home=$2
if [ -z "$home" ]; then
  home=~
fi

#TODO test existence first
ln -s "$repo/vim/rc" "$home/.vimrc"
ln -s "$repo/vim" "$home/.vim"
for f in .ackrc .gitconfig .gitignore .bash_completion .xinitrc; do
  ln -s "$repo/$f" "$home/$f"
done

include_cmd="source \"$repo/.bashrc\""
if [ -z "`grep "$include_cmd" "$home/.bashrc"`" ]; then
  echo "$include_cmd" >> "$home/.bashrc"
fi
