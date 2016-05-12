#!/usr/bin/env bash

# PHPBrew
if ! [ -d ~/.phpbrew ]; then
      phpbrew init;
fi;
source /srv/www/.phpbrew/bashrc

# NPM
if ! [ -d ~/.npm-global ]; then
      mkdir ~/.npm-global;
      npm config set prefix '~/.npm-global';
fi;
export PATH=~/.npm-global/bin:$PATH
