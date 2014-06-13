#!/bin/bash
# CPR : Jd Daniel :: Ehime-ken
# MOD : 2014-06-13 @ 16:23:53
# VER : 1.0
#
# bleh


## Stage profile
echo -e 'if [ -f ~/.bash_aliases ]; then\n  . ~/.bash_aliases\nfi' >> ~/.bashrc
echo -e 'if [ -f ~/.bash_profile ]; then\n  . ~/.bash_profile\nfi' >> ~/.bashrc



## Brew stuff
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
echo -e 'export PATH="$(brew --prefix coreutils)/libexec/gnubin:/usr/local/bin:$PATH"' >> ~/.bashrc


## GNU Utilities
brew install coreutils

## NIX your env
brew tap homebrew/dupes
brew install binutils
brew install diffutils
brew install ed --default-names
brew install findutils --default-names
brew install gawk
brew install gnu-indent --default-names
brew install gnu-sed --default-names
brew install gnu-tar --default-names
brew install gnu-which --default-names
brew install gnutls --default-names
brew install grep --default-names
brew install gzip
brew install screen
brew install watch
brew install wdiff --with-gettext
brew install wget


## Fresher bins
brew install bash
brew install emacs
brew install gdb  		# gdb requires further actions to make it work. See `brew info gdb`.
brew install gpatch
brew install m4
brew install make
brew install nano


## Short of learning how to actually configure OSX, here's a hacky way to use
## GNU manpages for programs that are GNU ones, and fallback to OSX manpages otherwise
echo -e "alias man='_() { echo $1; man -M $(brew --prefix)/opt/coreutils/libexec/gnuman $1 1>/dev/null 2>&1; if [ \"$?\" -eq 0 ]; then man -M $(brew --prefix)/opt/coreutils/libexec/gnuman $1; else man $1; fi }; _'" >> ~/.bash_profile



