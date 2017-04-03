#!/bin/bash
# Youtube to MP3 OSX Support installer

# CPR : Jd Daniel :: Ehime-ken
# MOD : 2017-04-02 @ 00:10:05
# VER : Version 2.1 (OSX Darwin)

## Install brew
hash brew 2>/dev/null || {
    ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
    brew doctor
}

## Install youtube-dl
hash youtube-dl 2>/dev/null || {
    brew install youtube-dl
}

brew install ffmpeg         \
    --with-fdk-aac          \
    --with-sdl2             \
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

curl -sSL https://goo.gl/1OqKsI >| /usr/local/bin/y2m.sh
chmod +x $_

[ 0 = $? ] { echo -e 'Fail..' ; return 1 ; } ## exit_fail 
return 0 
