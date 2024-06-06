{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.wl-clipboard
    pkgs.xclip
    pkgs.fcitx5-unikey

    pkgs.sway
    pkgs.swaylock
    pkgs.waybar
    pkgs.wlogout
    pkgs.pamixer
    pkgs.blueman
    pkgs.gtk3
    pkgs.brightnessctl
    pkgs.libinput-gestures
    pkgs.networkmanager_dmenu

    pkgs.helm

    pkgs.teams-for-linux
    pkgs.slack
  ];

}
