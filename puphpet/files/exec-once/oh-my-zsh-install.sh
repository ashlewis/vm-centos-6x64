#!/bin/bash
#

echo 'Installing oh-my-zsh'
wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O - | sh


if ! grep -R "zshrc_custom" "$HOME/.zshrc"; then
    echo 'Adding custom oh-my-zsh config'
    printf "\n# zshrc_custom\nsource .zshrc_custom\n" >> $HOME/.zshrc
fi