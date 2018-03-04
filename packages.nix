{ config, pkgs, ...}:

let
  nixcfg = {
    allowUnfree = true;
  };

  stable = import (fetchTarball https://github.com/nixos/nixpkgs-channels/archive/nixos-17.09.tar.gz) { config = nixcfg; };
  rolling = import (fetchTarball https://github.com/nixos/nixpkgs-channels/archive/nixos-unstable.tar.gz) { config = nixcfg; };
  edge = import (fetchTarball https://github.com/NixOS/nixpkgs/archive/master.tar.gz) { config = nixcfg; };
  pkgs = stable;

  base = (with stable; [
    file
    curl
    wget
    fish
    networkmanager
    dbus
    xclip
    xst
    git
    busybox
  ]) ++ (with rolling; [
    firefox
    thunderbird
    pcmanfm
    google-play-music-desktop-player
    file
    i3status-rust
  ]);

  extra = (with rolling; [
    # oomox
    gdk_pixbuf
    glib.dev
    gtk-engine-murrine
    gtk_engines
    gtk3
    sassc
    librsvg
    bc

    compton
    firefox
    gimp
    pcmanfm
    emacs
    evince
    
    feh
    rofi
  ]);

  games = (with edge; [
    superTuxKart
  ]);

  development = (with stable; [
    cargo
    autoconf
    automake
    boot
    cmake
    gcc
    ghc
    gnumake
    rustc
    rustfmt
    rustracer
    sqlite
    zeal
  ]) ++ (with rolling; [
    python3
  ]);

  basefonts = (with pkgs; [
    roboto-mono
    siji
    tewi-font
  ]);

  extrafonts = (with pkgs; [
    corefonts
    dejavu_fonts
    fantasque-sans-mono
    fira
    fira-code
    font-awesome-ttf
    font-droid
    noto-fonts
    powerline-fonts
    roboto
    roboto-slab
    source-code-pro
  ]);

in
{
  environment.systemPackages =
    base ++
    extra ++
    development ++
    games ++
    [];

  fonts.fonts =
    basefonts ++
    extrafonts ++
    [];
}
