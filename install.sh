#!/bin/bash

############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
conf="scripts awesome compton.conf"
files="bashrc ncmpcpp tmux.conf vim/colors vim/bundle/Vundle.vim vimperatorrc vimrc xbindkeysrc xprofile Xmodmap Xresources zshrc"    # list of files/folders to symlink in homedir

##########

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
echo "Installing /home dotfiles"
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/.$file ~/.$file
done
echo "Installing .config dotfiles"
for conf in $conf; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.config/$conf ~/dotfiles_old/
    echo "Creating symlink to $conf in home directory."
    ln -s $dir/.config/$conf ~/.config/$conf
done
echo "Done!"
