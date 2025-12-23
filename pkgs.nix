{ config, pkgs, inputs, ... }:
let
        zen-browser = (builtins.getFlake https://github.com/0xc000022070/zen-browser-flake/tarball/master).packages.x86_64-linux.default;
        ags = (builtins.getFlake https://github.com/aylur/ags/tarball/master).packages.x86_64-linux.default;
        orange3 = (builtins.getFlake https://github.com/scuggo/orange3-nix-fix/tarball/master).packages.x86_64-linux.default;
        alien = import (builtins.fetchTarball https://github.com/thiagokokada/nix-alien/tarball/master) {};

        yt-dlp = inputs.yt-dlp.packages.${pkgs.system}.default;
        # freedownloadmanager = inputs.freedownloadmanager.packages.${pkgs.system}.default;

        mommy = pkgs.mommy.overrideAttrs (oldAttrs: {
                src = pkgs.fetchFromGitHub {
                        owner = "aaaamida";
                        repo = "mommy";
                        rev = "16b36486c6412e9a587b3ba2f400130f1ce2017a";
                        hash = "sha256-HKaEw9utxz3vNtey5I4WOhF0v9EevUaLy0Ss3McTeX8=";
                };
        });

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
                # freedownloadmanager
                feh
                mpv
                libreoffice-qt6-fresh
                zathura
                obs-studio
                orange3
                qbittorrent-enhanced

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
                unrar
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
                jq
                difftastic
                nix-index
                mpg123
                timg
                sqlite-interactive

                # PL tools
                rustup
                cargo-leptos
                cargo-mommy
                python314
                clang
                libgcc
                gnumake
                cmake
                go
                typst
                nil
                nixd
                dotnet-sdk_9
                dotnet-runtime_9
                zig

                # wm
                wl-clipboard
                wl-clipboard-x11
                xdg-desktop-portal-hyprland
                hyprcursor
                hyprpaper
                hyprshot
                hypridle
                # waybar
                flameshot
                wev
                mpvpaper
                wlsunset
                brightnessctl
                nwg-displays
                ags
                quickshell

                # misc
                winboat
                freerdp
                cava
                bluetuith
                papirus-icon-theme
                nerd-fonts.iosevka-term-slab
                pavucontrol
                bluez
                mommy
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
                ds4drv
                # truststore
                # orange3
        ]);
}
