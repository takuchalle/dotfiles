#!/usr/bin/env bash
set -u

DOTFILES_DIR=$(dirname $0)
echo $DOTFILES_DIR

FILES=(.bashrc .vimrc .zshrc .tmux.conf .inputrc .gitconfig .gitignore .bash_alias)

for file in ${FILES[@]}; do 
	echo Linking... $DOTFILES_DIR/$file
	ln -s ~/$DOTFILES_DIR/$file ~/$file
done

