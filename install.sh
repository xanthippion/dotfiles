#!/bin/bash
############################
# install.sh
# This script backs up any existing dotfiles, and creates symlinks to the new dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # dotfiles backup directory
files="i3 vim gitconfig tmux.conf vimrc Xresources zlogin zlogout zpreztorc zprofile zshenv zshrc"    # list of files/folders to symlink in homedir

##########

# create dotfiles_old in homedir
echo -n "Creating $olddir ..."
mkdir -p $olddir
echo "done!"

# change to the dotfiles directory
echo -n "Changing to $dir ..."
cd $dir
echo "done!"

# move any existing dotfiles in homedir to dotfiles_old, and create symlinks from the homedir to the files in ~/dotfiles
for file in $files; do
    echo -n "Moving existing .$file to $olddir ..."
    mv ~/.$file ~/dotfiles_old/
    echo "done!"
    echo -n "Creating symlink for .$file ..."
    ln -s $dir/$file ~/.$file
    echo "done!"
done

# install base16-shell if it isn't present
if [[ ! -d ~/.config/base16-shell/ ]]; then
  echo -n "Installing Base16 Shell ..."
  git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
  echo "done!"
fi

# install prezto if it isn't present
if [[ ! -d ~/.zprezto/ ]]; then
  echo -n "Installing Prezto ..."
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
  echo "done!"
fi
