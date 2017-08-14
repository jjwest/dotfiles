#!/bin/bash

cp .gitignore_global $HOME
git config --global core.excludesfile $HOME/.gitignore_global
