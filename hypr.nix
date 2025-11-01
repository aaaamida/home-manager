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
                settings = builtins.fromJSON (builtins.readFile /home/amida/.config/noctalia/_settings.json);

                # settings = {
                #         bar = {
                #                 backgroundOpacity = 1;
                #                 position = "top";
                #                 monitors = [];
                #                 density = "comfortable";
                #                 showCapsule = true;
                #                 floating = false;
                #                 widgets = {
                #                         left = [
                #                                 { id = "SystemMonitor"; }
                #                                 { id = "Workspace"; }
                #                         ];
                #                         center = [
                #                                 {
                #                                         id = "MediaMini";
                #                                         scrollingMode = "always";
                #                                         maxWidth = 250;
                #                                         useFixedWidth = true;
                #                                         showAlbumArt = true;
                #                                 }
                #                                 {
                #                                         id = "AudioVisualizer";
                #                                         maxWidth = 250;
                #                                         useFixedWidth = true;
                #                                 }
                #                         ];
                #                         right = [
                #                                 { id = "Tray"; }
                #                                 { id = "NotificationHistory"; }
                #                                 { id = "PowerProfile"; }
                #                                 {
                #                                         id = "Battery";
                #                                         displayMode = "alwaysShow";
                #                                         warningThreshold = 40;
                #                                 }
                #                                 {
                #                                         id = "Volume";
                #                                         displayMode = "alwaysShow";
                #                                 }
                #                                 {
                #                                         id = "Brightness";
                #                                         displayMode = "alwaysShow";
                #                                 }
                #                                 { id = "Clock"; }
                #                                 {
                #                                         id = "ControlCenter";
                #                                         useDistroLogo = true;
                #                                 }
                #                         ];
                #                 };
                #                 general = {
                #                         showScreenCorners = false;
                #                         animationDisabled = true;
                #                         lockOnSuspend = false;
                #                 };
                #                 location = {
                #                         name = "Makassar";
                #                         weatherEnabled = true;
                #                         useFahrenheit = false;
                #                         use12hourFormat = false;
                #                 };
                #                 wallpaper.enabled = false;
                #                 appLauncher = {
                #                         enableClipboardHistory = true;
                #                         terminalCommand = "kitty -e";
                #                 };
                #                 dock = {
                #                         enabled = false;
                #                         monitors = [];
                #                 };
                #                 audio = {
                #                         volumeOverdrive = true;
                #                 };
                #                 ui = {
                #                         fontDefault = "IosevkaTermSlab Nerd Font";
                #                         fontFixed = "IosevkaTermSlab Nerd Font Mono";
                #                         fontDefaultScale = 1;
                #                         fontFixedScale = 1.2;
                #                 };
                #                 colorSchemes = {
                #                         useWallpaperColors = false;
                #                         predefinedScheme = "Rosepine";
                #                         darkMode = true;
                #                 };
                #         };
                # };
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
