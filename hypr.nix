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

        services.hypridle = {
                enable = true;
                settings = {
                        general = {
                                lock_cmd = "pidof hyprlock || hyprlock";
                                before_sleep_cmd = "loginctl lock-session";
                                after_sleep_cmd = "hyprctl dispatch dpms on";
                        };

                        listener = [
                                {
                                        timeout = 300;
                                        on-timeout = "brightnessctl -s set 10";
                                        on-resume = "brightnessctl -r";
                                }
                                {
                                        timeout = 600;
                                        on-timeout = "loginctl lock-session";
                                }
                                {
                                        timeout = 900;
                                        on-timeout = "hyprctl dispatch dpms off";
                                        on-resume = "hyprctl dispatch dpms on && brightnessctl -r";
                                }
                                {
                                        timeout = 1200;
                                        on-timeout = "systemctl suspend";
                                }
                        ];
                };
        };

        services.dunst = {
                enable = true;
                configFile = /home/amida/.df/hypr/dunst/dunstrc;
        };

        services.cliphist = {
                enable = true;
                allowImages = true;
        };
}
