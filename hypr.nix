{ config, pkgs, ... }:

{
        wayland.windowManager.hyprland = {
                enable = false;
                systemd = {
                        enable = true;
                        variables = [ "--all" ];
                };
        };

        programs.hyprlock.enable = true;

        services.hyprpaper.enable = true;

        services.hypridle.enable = true;

        services.dunst = {
                enable = true;
                configFile = /home/amida/.df/hypr/dunst/dunstrc;
        };

        services.cliphist = {
                enable = true;
                allowImages = true;
        };
}
