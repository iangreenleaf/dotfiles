#!/bin/sh

rcup -K rcrc
rcup

if uname -a | grep -q "Darwin"; then
  echo "You might want to run the following command to use the Karabiner config:"
  echo "\tln ~/.config/karabiner/karabiner.json .karabiner.json"
fi
