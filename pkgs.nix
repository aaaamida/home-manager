{ config, pkgs, inputs, ... }:
let
        zen-browser = (builtins.getFlake https://github.com/0xc000022070/zen-browser-flake/tarball/master).packages.x86_64-linux.default;
        ags = (builtins.getFlake https://github.com/aylur/ags/tarball/master).packages.x86_64-linux.default;
        freedownloadmanager = import (pkgs.fetchFromGitHub {
                owner = "aaaamida";
                repo  = "nix-fdm";
                rev   = "310d406923c68d4258a1d50cbc298b6163bacc9c";
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
                obs-studio

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
                file
                krisp-patcher
                ookla-speedtest
                ffmpeg
                jmtpfs

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
                gopls
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
                nwg-displays
                ags

                # misc
                bluetuith
                papirus-icon-theme
                nerd-fonts.iosevka-term-slab
                pavucontrol
                bluez
                amdgpu_top
                nvtopPackages.amd
                docker
                wineWowPackages.full
                umu-launcher
                (lutris.override {
                        extraLibraries = pkgs: [ libadwaita ];
                })
        ]
        ++ [ alien.nix-alien ]
        ++ (with kdePackages; [
                filelight
                qt6ct
        ])
        ++ (with python313Packages; [
                truststore
                altair
        ]);
}
