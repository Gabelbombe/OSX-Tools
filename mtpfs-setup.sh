#!/bin/bash

cd ~/Repositories

https://github.com/phatina/simple-mtpfs.git
mkdir -psimple-mtpfs/build/ && cd $_

	brew install libmtp fuse4x sshfs
  	brew unlink fuse4x
	brew link fuse4x

../configure && make
sudo make install

simple-mtpfs --list-devices