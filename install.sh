#!/bin/sh

DOTFILES=$HOME/.config
NIXPKGS=$DOTFILES/nixpkgs
WALLPAPER="https://raw.githubusercontent.com/d4ilyrun/dotfiles/master/Images/Wallpaper/16%20-%20hTz6ikt.jpg"

# remove i3 config files
[[ -f $DOTFILES/i3 ]] || rm -rf $DOTFILES/i3

# Add necessary channels
nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
nix-channel --add https://github.com/nix-community/home-manager/archive/release-21.05.tar.gz home-manager
nix-channel --update

# Install home-manager for nix 21.05
echo "Installing home-manager..."
if [ -d $HOME/.nix_defexpr ]; then
    export NIX_PATH=$HOME/.nix_defexpr/channels${NIX_PATH:+:}$NIX_PATH
elif [ -d $HOME/.nix-defexpr ]; then
    export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH
else
    echo "No path for '.nix_defexpr'. Stop." 1&>2
fi
nix-shell '<home-manager>' -A install

# clone wallpaper
curl -L $WALLPAPER -o $HOME/.wallpaper.jpg

# install oh-my fish
echo "Installing oh-my-fish..."
OMF_THEME='bobthefish'
curl -L "https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install" | fish
omf install $OMF_THEME

# Install polybar
cd $NIXPKGS/programs/desktop/polybar
sh install_collection.sh
