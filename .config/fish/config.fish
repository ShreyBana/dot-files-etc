set -gx EDITOR nvim
set -gx FZF_DEFAULT_COMMAND 'fd --type f'
alias ls="exa -l -s type -s extension"
alias ls-tree="ls -T -L "
alias conf="ranger $HOME/.config/"
alias conf-ranger="ranger $HOME/.config/nvim/"
alias conf-polybar="ranger $HOME/.config/polybar/"
alias conf-i3="nvim $HOME/.config/i3/config"
alias conf-rofi="ranger $HOME/.config/rofi/"
alias conf-alacritty="nvim $HOME/.config/alacritty/alacritty.yml"
alias conf-xmonad="ranger $HOME/.config/xmonad/"
alias conf-picom="nvim $HOME/.config/picom/config"
alias conf-nvim="nvim $HOME/.config/nvim/init.vim"
alias conf-fish="ranger $HOME/.config/fish/"
starship init fish | source
