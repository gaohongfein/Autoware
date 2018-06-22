#!/bin/bash

color_prompt=yes

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize
stty cols 180
stty rows 280

txtrst="$(tput sgr 0)"    # Text Reset
txtred="$(tput setaf 1)"  # Red
txtgrn="$(tput setaf 2)"  # Green
txtylw="$(tput setaf 3)"  # Yellow
txtblu="$(tput setaf 4)"  # Blue
txtpur="$(tput setaf 5)"  # Purple
txtcyn="$(tput setaf 6)"  # Cyan

if [ -f /.dockerenv ]; then
    echo "Inside Docker";
    export PS1="\[$txtcyn\] [in_docker] \[$txtrst\] $PS1"
else
    echo "Not inside Docker";
fi

# History handling
bind '"\e[5~": history-search-backward'
bind '"\e[6~": history-search-forward'

# Load the gazebo environment
if [ -e /usr/share/gazebo/setup.sh ] ; then
    source /usr/share/gazebo/setup.sh
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
        elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi


source /opt/ros/kinetic/setup.bash

if [ -e ~/Autoware/ros/devel/setup.bash ] ; then
    source ~/Autoware/ros/devel/setup.bash
fi

# Setting
LANG=en_US.UTF-8