set -gx EDITOR nvim
set -gx FZF_DEFAULT_COMMAND 'fd --type f'
alias ls="exa -l -s type -s extension"
alias ls-tree="ls -T -L "
alias conf-nvim="nvim $HOME/.config/nvim/init.vim"
alias conf-polybar="nvim $HOME/.config/polybar/"
alias conf-i3="nvim $HOME/.config/i3/config"
alias conf-rofi="nvim $HOME/.config/rofi/"
alias conf-alacritty="nvim $HOME/.config/alacritty/alacritty.yml"
starship init fish | source
