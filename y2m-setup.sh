#!/bin/bash


## Install brew
[ hash brew 2>/dev/null ] || {
	ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
	brew doctor
}

## Install youtube-dl
[ hash youtube-dl 2>/dev/null ] || {
	brew install youtube-dl
}

brew install ffmpeg 		\
	--with-fdk-aac			\
	--with-ffplay			\
	--with-libass			\
	--with-libvidstab		\
	--with-libvo-aacenc		\
	--with-libvorbis		\
	--with-libvpx			\
	--with-opencore-amr		\
	--with-openssl			\
	--with-opus				\
	--with-theora			\
	--with-tools			\
	--with-x265
