set -gx FZF_DEFAULT_COMMAND 'fd --type f'
set -gx TERM "xterm-256color"
set -gx STARSHIP_LOG "error"
set -gx PRETTIERD_DEFAULT_CONFIG "$HOME/sdk/.prettierrc.json"
set -gx NVM_DIR "$HOME/.nvm"
set -gx NVIM_TUI_ENABLE_CURSOR_SHAPE 1
#set -gx JDTLS_HOME "/opt/homebrew/Cellar/jdtls/1.11.0/libexec"
set -gx NIXOS_CONFIG "$HOME/configuration.nix"

# postgresql 
# set -gx LDFLAGS "-L/usr/local/homebrew/opt/postgresql@12/lib"
# set -gx CPPFLAGS "-L/usr/local/homebrew/opt/postgresql@12/include"

alias ls="exa --icons -l --sort=extension --sort=type --git"
alias ls-tree="ls -T -L "
alias gco="git checkout"
alias axbrew='arch -x86_64 /usr/local/homebrew/bin/brew'
alias brew='/opt/homebrew/bin/./brew'
alias findz='fd --type f | fzf'
alias sd "cd ~ && cd (find * -type d | fzf)"

starship init fish | source

function conf 
  nvim $HOME/.config/$argv[1]
end

#set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin $PATH /Users/shrey.bana/.ghcup/bin # ghcup-env
#set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin $PATH /Users/shrey.bana/.ghcup/bin # ghcup-env
#set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin $PATH /Users/shrey.bana/.ghcup/bin # ghcup-env

# Seoul256 Night
set -gx FZF_DEFAULT_OPTS '
--color fg:242,bg:233,hl:65,fg+:15,bg+:234,hl+:108
--color info:108,prompt:109,spinner:108,pointer:168,marker:168'
