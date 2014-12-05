#!/bin/bash
# Youtube to MP3 OSX Support installer
 
# CPR : Jd Daniel :: Ehime-ken
# MOD : 2014-12-05 @ 10:54:55
# VER : Version 2 (OSX Darwin)

## ROOT check
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as su..." 1>&2 ; exit 1
fi

## Install brew
[ hash brew 2>/dev/null ] || {
    ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
    brew doctor
}

## Install youtube-dl
[ hash youtube-dl 2>/dev/null ] || {
    brew install youtube-dl
}

brew install ffmpeg         \
    --with-fdk-aac          \
    --with-ffplay           \
    --with-libass           \
    --with-libvidstab       \
    --with-libvo-aacenc     \
    --with-libvorbis        \
    --with-libvpx           \
    --with-opencore-amr     \
    --with-openssl          \
    --with-opus             \
    --with-theora           \
    --with-tools            \
    --with-x265

brew install curl

cd /tmp/ && curl -sSL https://raw.githubusercontent.com/ehime/OSX-Tools/master/y2m.sh

mv 'y2m.sh' /usr/local/bin/y2m