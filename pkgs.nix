{ config, pkgs, inputs, ... }:
let
        zen-browser = (builtins.getFlake https://github.com/0xc000022070/zen-browser-flake/tarball/master).packages.x86_64-linux.default;
        freedownloadmanager = import (pkgs.fetchFromGitHub {
                owner = "aaaamida";
                repo  = "nix-fdm";
                rev   = "master";
                hash  = "sha256-QYIM2bcK9WOhvbjZ8REHAdwbWLTz9fEh+34ssPM3j4Q=";
        }) {};
        alien = import (builtins.fetchTarball https://github.com/thiagokokada/nix-alien/tarball/master) {};
        krisp-patcher = pkgs.writers.writePython3Bin "krisp-patcher" {
                libraries = with pkgs.python313Packages; [ capstone pyelftools ];
                flakeIgnore = [ "E501" "F403" "F405" ];
        } (builtins.readFile (pkgs.fetchurl {
                url = "https://pastebin.com/raw/8tQDsMVd";
                sha256 = "sha256-IdXv0MfRG1/1pAAwHLS2+1NESFEz2uXrbSdvU9OvdJ8=";
        }));
in
{
        home.packages = with pkgs; [
                # GUI apps
                zen-browser
                discord
                youtube-music
                freedownloadmanager
                feh
                mpv
                libreoffice-qt6-fresh
                zathura

                # CLI utils
                lazygit
                fzf
                gh
                fastfetch
                hyfetch
                yt-dlp
                betterdiscordctl
                appimage-run
                zoxide
                bat
                eza
                fd
                p7zip
                unzip
                asciiquarium
                libnotify
                ripgrep
                killall
                playerctl
                opencode
                krisp-patcher

                # PL tools
                rustup
                clang
                python314
                libgcc
                gnumake
                cmake
                nodejs_24
                bun
                go
                typst

                # wm
                wl-clipboard
                wl-clipboard-x11
                xdg-desktop-portal-hyprland
                hyprcursor
                hyprpaper
                hyprshot
                hypridle
                waybar
                flameshot
                wev
                mpvpaper
                wlsunset
                brightnessctl

                # misc
                papirus-icon-theme
                nerd-fonts.iosevka-term-slab
                pavucontrol
        ]
        ++ [ alien.nix-alien ]
        ++ (with kdePackages; [
                filelight
        ])
        ++ (with python313Packages; [
                truststore
                altair
        ]);
}
