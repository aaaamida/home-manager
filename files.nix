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
}
