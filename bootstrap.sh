#!/bin/bash

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

git submodule init 
git submodule update dotdrop 

if command -v pip3 >/dev/null 2>&1; then
  cd ~/dotfiles && 
  pip3 install --user -r dotdrop/requirements.txt &&
  dotdrop/bootstrap.sh &&
  chmod u+x dotdrop.sh &&
  ./dotdrop.sh install -p fell
else
  echo "Python3 not installed"
fi

if command -v curl >/dev/null 2>&1; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/romkatv/zsh4humans/v5/install)"
else
  sh -c "$(wget -O- https://raw.githubusercontent.com/romkatv/zsh4humans/v5/install)"
fi