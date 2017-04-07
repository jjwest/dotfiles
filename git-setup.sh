#!/bin/bash

cp $HOME/dotfiles/.gitignore_global $HOME
git config --global core.excludesfile $HOME/.gitignore_global
