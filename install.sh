#!/bin/bash
#Place the Dotfiles folder on your home directory.
#Run the script.
#Disclaimer: This might not work in your system. So, the best way is to use copy paste if you are planning to clone it..

ln -s ~/Dotfiles/vim/vimrc ~/.vimrc #for vim

ln -s ~/Dotfiles/ranger/rifle.conf ~/.config/ranger/rifle.conf #for ranger
ln -s ~/Dotfiles/ranger/rc.conf ~/.config/ranger/rc.conf
ln -s ~/Dotfiles/ranger/devicon.py ~/.config/ranger/plugin/devicon.py
ln -s ~/Dotfiles/ranger/__init__.py ~/.config/ranger/plugin/__init__.py

ln -s ~/Dotfiles/bash/bashrc ~/.bashrc #For bash

ln -s ~/Dotfiles/sxiv/key-handler ~/.config/sxiv/exec/key-handler #For sxiv

ln -s ~/Dotfiles/zathura/zathurarc ~/.config/zathura/zathurarc #For zathura

