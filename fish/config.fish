set fish_greeting

if test (tty) = "/dev/tty1"
    exec Hyprland
end

set -U fish_user_paths /home/henning/.local/share/bob/nvim-bin $fish_user_paths
set -U fish_user_paths /home/henning/.local/bin $fish_user_paths

alias et "nvim ~/.config/tmux/tmux.conf"
alias ef "nvim ~/.config/fish/config.fish"
alias en "cd ~/.config/nvim && nvim"
alias eh "nvim ~/.config/hypr/hyprland.conf"
alias ek "nvim ~/.config/kitty/kitty.conf"
alias config "git --git-dir=$HOME/.config/.cfg/ --work-tree=$HOME/.config"
alias qei "nvim qmk_firmware/keyboards/smithrune/iron165r2/keymaps/HenningCode/keymap.c"
alias ll "ls -lh --group-directories-first --color=auto"
alias ls "ls -h --group-directories-first --color=auto"
alias vi "nvim"
alias tu "tmux"
alias hx "helix"


function space
    if count $argv > /dev/null
        du -sh $argv/*
    else
        du -sh *
    end
end

/home/henning/Dev/Rust/starship/target/debug/starship init fish | source
