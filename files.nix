{ config, pkgs, ... }:

{
        xdg.configFile = {
                neovim = {
                        recursive = true;
                        source = /home/amida/.df/nvim;
                        target = "nvim";
                };

                yazi = {
                        recursive = true;
                        source = /home/amida/.df/yazi;
                        target = "yazi";
                        force = true;
                };

                kitty = {
                        recursive = true;
                        source = /home/amida/.df/kitty;
                        target = "kitty";
                        force = true;
                };

                tmux = {
                        recursive = true;
                        source = /home/amida/.df/tmux;
                        target = "tmux";
                        force = true;
                };

                btop = {
                        recursive = true;
                        source = /home/amida/.df/btop;
                        target = "btop";
                        force = true;
                };

                hyprland = {
                        recursive = true;
                        source = /home/amida/.df/hypr;
                        target = "hypr";
                        force = true;
                };

                hyprlock = {
                        source = /home/amida/.df/hypr/lock;
                        target = "hyprlock";
                        force = true;
                };

                hypridle = {
                        source = /home/amida/.df/hypr/idle;
                        target = "hypridle";
                        force = true;
                };

                dunst = {
                        source = /home/amida/.df/hypr/dunst;
                        target = "dunst";
                        force = true;
                };

                waybar = {
                        source = /home/amida/.df/hypr/waybar;
                        target = "waybar";
                        force = true;
                };
        };

        xdg.mimeApps = {
                enable = true;
                defaultApplications = {
                        "x-scheme-handler/betterdiscord" = "discord.desktop";
                        "x-scheme-handler/http"          = "zen-beta.desktop";
                        "x-scheme-handler/https"         = "zen-beta.desktop";
                        "x-scheme-handler/chrome"        = "zen-beta.desktop";
                        "text/html"                      = "zen-beta.desktop";
                        "application/x-extension-htm"    = "zen-beta.desktop";
                        "application/x-extension-html"   = "zen-beta.desktop";
                        "application/x-extension-shtml"  = "zen-beta.desktop";
                        "application/xhtml+xml"          = "zen-beta.desktop";
                        "application/x-extension-xhtml"  = "zen-beta.desktop";
                        "application/x-extension-xht"    = "zen-beta.desktop";
                        "x-scheme-handler/fdm"           = "freedownloadmanager_fdm_up.desktop";
                        "x-scheme-handler/magnet"        = "freedownloadmanager_fdm_magnet_up.desktop";
                        "application/x-bittorrent"       = "freedownloadmanager_torrent.desktop";
                };

                associations.added = {
                        "x-scheme-handler/http"         = [ "zen-beta.desktop" "userapp-Zen-SE40C3.desktop" ];
                        "x-scheme-handler/https"        = [ "zen-beta.desktop" "userapp-Zen-SE40C3.desktop" ];
                        "x-scheme-handler/chrome"       = [ "zen-beta.desktop" "userapp-Zen-SE40C3.desktop" ];
                        "text/html"                     = [ "zen-beta.desktop" "userapp-Zen-SE40C3.desktop" ];
                        "application/x-extension-htm"   = [ "zen-beta.desktop" "userapp-Zen-SE40C3.desktop" ];
                        "application/x-extension-html"  = [ "zen-beta.desktop" "userapp-Zen-SE40C3.desktop" ];
                        "application/x-extension-shtml" = [ "zen-beta.desktop" "userapp-Zen-SE40C3.desktop" ];
                        "application/xhtml+xml"         = [ "zen-beta.desktop" "userapp-Zen-SE40C3.desktop" ];
                        "application/x-extension-xhtml" = [ "zen-beta.desktop" "userapp-Zen-SE40C3.desktop" ];
                        "application/x-extension-xht"   = [ "zen-beta.desktop" "userapp-Zen-SE40C3.desktop" ];
                };
        };

        xdg.desktopEntries = {
                feh = {
                        name = "feh";
                        exec = "feh %f";
                        mimeType = [
                                "image/png"
                                "image/jpg"
                                "image/jpeg"
                                "image/webp"
                        ];
                };

                mpv = {
                        name = "mpv";
                        exec = "feh %f";
                        mimeType = [
                                "video/mp4"
                                "video/3gpp"
                                "video/matroska"
                        ];
                };

                nvim = {
                        name = "nvim";
                        exec = "nvim %f";
                        mimeType = [
                                "text/csv"
                                "text/javascript"
                                "text/xml"
                        ];
                };

                zathura = {
                        name = "zathura";
                        exec = "zathura %f";
                        mimeType = [ "application/pdf" ];
                };

                zen = {
                        name = "zen";
                        exec = "zen-beta %f";
                        mimeType = [ "image/svg+xml" ];
                };

                zzz = {
                        name = "Zenless Zone Zero";
                        exec = "umu-run /home/amida/Games/ZZZ.exe %f";
                        terminal = false;
                        categories = [ "Game" ];
                };
        };
}
