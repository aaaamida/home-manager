{ config, pkgs, inputs, ... }:

{
        imports = [ inputs.noctalia.homeModules.default ];

        wayland.windowManager.hyprland = {
                enable = false;
                systemd = {
                        enable = true;
                        variables = [ "--all" ];
                };
        };

        programs.hyprlock.enable = true;

        programs.hyprpanel = {
                enable = true;
                # dontAssertNotificationDaemons = true;
        };

        programs.noctalia-shell = {
                enable = true;
                settings = builtins.fromJSON (builtins.readFile /home/amida/.config/noctalia/writable_settings.json);
        };

        services.dunst = {
                enable = false;
                configFile = /home/amida/.df/hypr/dunst/dunstrc;
        };

        services.cliphist = {
                enable = true;
                allowImages = true;
        };
}
