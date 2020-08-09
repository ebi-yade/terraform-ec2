# .bash_profile for local AmazonLinux2 Container

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/.local/bin:$HOME/bin

export PATH

# Additional Config

export GOPATH=$HOME/go