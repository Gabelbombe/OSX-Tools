#!/bin/bash

if ! hash brew; then
	echo 'Installing Homebrew...'
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update && brew upgrade

brew doctor
brew install hg go

[ -d $HOME/go ] || mkdir $HOME/go
echo -e 'export GOPATH=$HOME/go\nexport PATH="$GOPATH/bin:$PATH"\nexport PATH="$PATH:/usr/local/opt/go/libexec/bin"' >> $HOME/.bashrc
echo "Installation complete...."
