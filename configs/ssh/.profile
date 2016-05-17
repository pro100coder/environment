# PHPBrew
if ! [ -d ~/.phpbrew ]; then
      phpbrew init;
fi
source /srv/www/.phpbrew/bashrc;

# NPM
if ! [ -d ~/.npm-global ]; then
      mkdir ~/.npm-global;
      npm config set prefix '~/.npm-global';
fi
export PATH=~/.npm-global/bin:$PATH;

# Default
source /etc/skel/.bashrc

echo ''
echo '|||||||||||||||||||||||||||||||||'
echo '|||||||||| WORK HARD ||||||||||||'
echo '|||||||||| PLAY HARD ||||||||||||'
echo '|||||||||||||||||||||||||||||||||'
echo ''
