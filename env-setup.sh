#!/bin/bash
# CPR : Jd Daniel :: Ehime-ken
# MOD : 2014-06-13 @ 16:23:53
# VER : 1.0
#
# bleh

## Update Brew
brew update


## GNU Utilities
brew install coreutils


## NIX your env
brew tap homebrew/dupes
brew install binutils
brew install diffutils
brew install ed --with-default-names
brew install findutils --with-default-names
brew install gawk
brew install gnu-indent --with-default-names
brew install gnu-sed --with-default-names
brew install gnu-tar --with-default-names
brew install gnu-which --with-default-names
brew install gnutls --with-default-names
brew install grep --with-default-names
brew install gzip
brew install screen
brew install watch
brew install wdiff --with-gettext
brew install wget
brew install expect


## Fresher bins
brew install bash
brew install emacs
brew install gdb      # gdb requires further actions to make it work. See `brew info gdb`.
brew install gpatch
brew install m4
brew install make
brew install nano

for candidate in "$(grep -l AmazonWebServicesFormula /usr/local/Library/Formula/*.rb | awk -F/ '{sub(/.rb$/,""); print " " $NF}')"; do
  brew install $candidate
done

## Cask install VBox and Vagranto
echo "-- Installing VirtualBox and Vagrant"
brew cask install virtualbox
brew cask install vagrant

## Add trusted certs
#security import /tmp/MyCertificates.p12 -k $HOME /Library/Keychains/login.keychain -P -T /usr/bin/codesign
