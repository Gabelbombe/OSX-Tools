#!/bin/bash
# CPR : Jd Daniel :: Ehime-ken
# MOD : 2014-06-13 @ 16:23:53
# VER : 1.0
#
# bleh


## ROOT check
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as su" 1>&2 ; exit 1
fi


## Stage profile
echo -e 'if [ -f ~/.bash_aliases ]; then\n  . ~/.bash_aliases\nfi' >> ~/.bashrc
curl -X GET https://raw.githubusercontent.com/ehime/Bash-Tools/master/.generic-bash_aliases >> ~/.bash_aliases
echo -e 'if [ -f ~/.bash_profile ]; then\n  . ~/.bash_profile\nfi' >> ~/.bashrc


## Brew stuff
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
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
brew install expect


## Must have
brew install git
curl -X GET https://raw.githubusercontent.com/ehime/Bash-Tools/master/.gitconfig >> ~/.gitconfig
brew install unzip

## Fresher bins
brew install bash
brew install emacs
brew install gdb      # gdb requires further actions to make it work. See `brew info gdb`.
brew install gpatch
brew install m4
brew install make
brew install nano


## Short of learning how to actually configure OSX, here's a hacky way to use
## GNU manpages for programs that are GNU ones, and fallback to OSX manpages otherwise
echo -e "alias man='_() { echo $1; man -M $(brew --prefix)/opt/coreutils/libexec/gnuman $1 1>/dev/null 2>&1; if [ \"$?\" -eq 0 ]; then man -M $(brew --prefix)/opt/coreutils/libexec/gnuman $1; else man $1; fi }; _'" >> ~/.bash_profile


for candidate in "$(grep -l AmazonWebServicesFormula /usr/local/Library/Formula/*.rb | awk -F/ '{sub(/.rb$/,""); print " " $NF}')"; do 
  brew install $candidate
done


# Bootstrap Puppet onto OSX
# Optional environmental variables:
# - FACTER_PACKAGE_URL: The URL to the Facter package to install.
# - HIERA_PACKAGE_URL:  The URL to the Hiera  package to install.
# - PUPPET_PACKAGE_URL: The URL to the Puppet package to install.

set -e  ## Exit if SHTF

#--------------------------------------------------------------------
# Modifiable variables, please set them via environmental variables.
#--------------------------------------------------------------------
function get_latest()
{
  local url="$1"
  local name="$2"

  echo "${url%/}/$(curl -s "${url}" |grep -oE ">${name}-([0-9]|latest).*dmg" |cut -c 2- |sort -rV |head -1)"
}

FACTER_PACKAGE_URL=${FACTER_PACKAGE_URL:-"$(get_latest 'http://downloads.puppetlabs.com/mac/' 'facter')"}
HIERA_PACKAGE_URL=${HIERA_PACKAGE_URL:-"$(get_latest   'http://downloads.puppetlabs.com/mac/' 'hiera')"}
PUPPET_PACKAGE_URL=${PUPPET_PACKAGE_URL:-"$(get_latest 'http://downloads.puppetlabs.com/mac/' 'puppet')"}

# This function will download a DMG from a URL, mount it, find
# the `pkg` in it, install that pkg, and unmount the package.
function install_dmg() 
{
  local name="$1"
  local url="$2"
  local dmg_path=$(mktemp -t "${name}-dmg-XXXXXX")

  echo -e "Installing: ${name}\nImage file: ${url}"

  # Download the package into the temporary directory
  echo "-- Downloading DMG..."
  curl -s -L -o "${dmg_path}" "${url}"

  # Mount it
  echo "-- Mounting DMG..."
  local plist_path=$(mktemp -t puppet-bootstrap-XXXXXX)
  hdiutil attach -plist "${dmg_path}" > "${plist_path}"
  mount_point=$(grep -E -o '/Volumes/[-.a-zA-Z0-9]+' "${plist_path}")

  # Install. It will be the only pkg in there, so just find any pkg
  echo "-- Installing pkg..."
  pkg_path=$(find "${mount_point}" -mindepth 1 -maxdepth 1 -name '*.pkg')
  installer -pkg "${pkg_path}" -target / > /dev/null


  # Unmount
  echo "-- Unmounting and ejecting DMG..."
  hdiutil eject "${mount_point}" > /dev/null

  echo -e "-- Successful\n"
}

# Install Facter, Hiera and Puppet
install_dmg "Facter" "${FACTER_PACKAGE_URL}"
install_dmg "Heira"  "${HIERA_PACKAGE_URL}"
install_dmg "Puppet" "${PUPPET_PACKAGE_URL}"

# Hide all users from the loginwindow with uid below 500, which will include the puppet user
defaults write /Library/Preferences/com.apple.loginwindow Hide500Users -bool YES


## Cask install VBox and Vagrant
brew cask install virtualbox
brew cask install vagrant



##pki='http://dp.t-mobile.com/pki/'
##sudo security add-trusted-cert -d -r trustRoot -k "/Library/Keychains/System.keychain" "/private/tmp/certs/certname.cer"


