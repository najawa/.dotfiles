# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.bin" ] ; then
    PATH="$HOME/.bin:$PATH"
fi

# Environment Variables
if [ -f "$HOME/.env" ]; then
    . "$HOME/.env"
fi


# asdf version management
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

# place chrome cache under /tmp which is a tmpfs
mkdir -p /tmp/$USER/google-chrome-cache
rm -rf ~/.cache/google-chrome
ln -s /tmp/$USER/google-chrome-cache ~/.cache/google-chrome

