set fish_greeting

if test (tty) = "/dev/tty1"
    exec Hyprland
end

set -U fish_user_paths  /home/henning/.local/share/bob/nvim-bin $fish_user_paths

alias ef "nvim ~/.config/fish/config.fish"
alias en "cd ~/.config/nvim && nvim"
alias eh "nvim ~/.config/hypr/hyprland.conf"
alias ek "nvim ~/.config/kitty/kitty.conf"
alias config "git --git-dir=$HOME/.config/.cfg/ --work-tree=$HOME/.config"

source (/usr/bin/starship init fish --print-full-init | psub)