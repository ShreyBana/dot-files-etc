# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH
PS1="\[\e[0;32m\]\w\[\e[0m\]\n " 

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
alias cls='clear'
alias catpaste="xclip -o | cat "
export maincpp='/home/shrey_bana/Templates/main.cpp'
alias maincat='cat < $maincpp | cat'

export VISUAL=vim
export EDITOR="$VISUAL"
