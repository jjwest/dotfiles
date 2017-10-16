#!/bin/bash

cp .gitignore_global $HOME
git config --global pull.rebase true
git config --global user.name "Jonas Westlund"
git config --global user.email "jonaswestlund101@gmail.com"
git config --global core.excludesfile $HOME/.gitignore_global
