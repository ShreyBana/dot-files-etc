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
PS1='\e[0;32m[\W]\e[0m >'

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
alias cls='clear'
alias catpaste="xclip -o | cat "
export maincpp='/home/shreybana/Templates/main.cpp'
alias maincat='cat < $maincpp | cat'
