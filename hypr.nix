{ config, pkgs, ... }:

{
        wayland.windowManager.hyprland = {
                enable = false;
                systemd = {
                        enable = true;
                        variables = [ "--all" ];
                };
        };

        # wayland.windowManager.hyprland.settings = {
        #         # init
        #         monitor = ",1920x1080@60,0x0,1";
        #
        #         exec-once = [
        #                 "hyprpaper &"
        #                 "hyprctl setcursor MegurineLukaHw 24"
        #                 "/home/amida/.df/hypr/scripts/waybar.sh"
        #                 "wl-paste --type text --watch cliphist store"
        #                 "wl-paste --type image --watch cliphist store"
        #                 "dunst -conf ~/.df/hypr/dunst/dunstrc"
        #         ];
        #
        #         env = [
        #                 "XCURSOR_SIZE,24"
        #                 "XCURSOR_THEME,MegurineLukaHw"
        #                 "HYPRCURSOR_SIZE,24"
        #                 "HYPRCURSOR_THEME,MegurineLukaHw"
        #         ];
        #
        #         # appearance
        #         general = {
        #                 gaps_in = 2;
        #                 gaps_out = 0;
        #                 border_size = 2;
        #                 "col.active_border" = "rgb(55cdfc) rgb(f7a8b8) rgb(ffffff) rgb(f7a8b8) rgb(55cdfc) 90deg";
        #                 "col.inactive_border" = "rgb(d62900) rgb(ef7627) rgb(ff9b55) rgb(ffffff) rgb(d461a6) rgb(b55690) rgb(a50062) 90deg";
        #                 resize_on_border = true;
        #                 allow_tearing = false;
        #                 layout = "dwindle";
        #                 snap = {
        #                         enabled = true;
        #                 };
        #         };
        #
        #         decoration = {
        #                 rounding = 0;
        #                 rounding_power = 4;
        #                 active_opacity = 1.0;
        #                 inactive_opacity = 1.0;
        #                 shadow = {
        #                         enabled = true;
        #                         range = 4;
        #                         render_power = 3;
        #                         color = "rgba(1a1a1aee)";
        #                 };
        #                 blur = {
        #                         enabled = true;
        #                         size = 3;
        #                         passes = 1;
        #                         vibrancy = 0.1696;
        #                 };
        #         };
        #
        #         animations.enabled = true;
        #
        #         dwindle = {
        #                 pseudotile = true;
        #                 preserve_split = true;
        #                 force_split = 2;
        #         };
        #
        #         master.new_status = "master";
        #
        #         # keybinds #
        #         unbind = [ "ALT_R" "ALT_L" ];
        #         bind = [
        #                 "SUPER, T, exec, kitty"
        #                 "SUPER, Z, exec, zen-beta"
        #                 "SUPER, D, exec, discord"
        #                 "SUPER, Y, exec, nixGL youtube-music --enable-features=UseOzonePlatform --ozone-platform=wayland"
        #                 "SUPER SHIFT, D, exec, discord-ptb"
        #                 "SUPER, E, exec, dolphin"
        #                 "SUPER, V, togglefloating, "
        #                 "SUPER, Menu, exec, $menu"
        #                 "SUPER ALT, Space, exec, $menu"
        #
        #                 "SUPER, P, pseudo,"
        #                 ", F10, fullscreen, 1"
        #                 "SUPER, J, togglesplit,"
        #                 "SUPER, Q , killactive,"
        #                 "ALT_L, F4, killactive,"
        #
        #                 "SUPER, left, movefocus, l"
        #                 "SUPER, right, movefocus, r"
        #                 "SUPER, up, movefocus, u"
        #                 "SUPER, down, movefocus, d"
        #
        #                 "SUPER, 1, workspace, 1"
        #                 "SUPER, 2, workspace, 2"
        #                 "SUPER, 3, workspace, 3"
        #                 "SUPER, 4, workspace, 4"
        #                 "SUPER, 5, workspace, 5"
        #                 "SUPER, 6, workspace, 6"
        #                 "SUPER, 7, workspace, 7"
        #                 "SUPER, 8, workspace, 8"
        #                 "SUPER, 9, workspace, 9"
        #                 "SUPER, 0, workspace, 10"
        #
        #                 "SUPER SHIFT, 1, movetoworkspace, 1"
        #                 "SUPER SHIFT, 2, movetoworkspace, 2"
        #                 "SUPER SHIFT, 3, movetoworkspace, 3"
        #                 "SUPER SHIFT, 4, movetoworkspace, 4"
        #                 "SUPER SHIFT, 5, movetoworkspace, 5"
        #                 "SUPER SHIFT, 6, movetoworkspace, 6"
        #                 "SUPER SHIFT, 7, movetoworkspace, 7"
        #                 "SUPER SHIFT, 8, movetoworkspace, 8"
        #                 "SUPER SHIFT, 9, movetoworkspace, 9"
        #                 "SUPER SHIFT, 0, movetoworkspace, 10"
        #
        #                 "ALT_L, TAB, cyclenext"
        #                 "ALT_L SHIFT, TAB, cyclenext, prev"
        #
        #                 "SUPER, S, togglespecialworkspace, magic"
        #                 "SUPER SHIFT, S, movetoworkspace, special:magic"
        #                 "SUPER ALT, S, movetoworkspace, e+0"
        #                 "SUPER, F1, togglespecialworkspace, mini"
        #                 "SUPER, F2, movetoworkspace, special:mini"
        #                 "SUPER, F3, movetoworkspace, e+0"
        #                 "SUPER, mouse_down, workspace, e+1"
        #                 "SUPER, mouse_up, workspace, e-1"
        #
        #                 "SUPER SHIFT, C, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
        #
        #                 ", Print, exec, ~/.df/hypr/scripts/flare region"
        #                 "SHIFT, Print, exec, ~/.df/hypr/scripts/flare full"
        #                 "ALT  , Print, exec, hyprshot -m window -m active --output-folder ~/Pictures/Screenshots/$(date +'%Y/%b/%d')"
        #
        #                 "SUPER, Space, exec, ~/.df/hypr/scripts/waybar.sh"
        #                 "SUPER CTRL SHIFT ALT, L, exec, zen-browser linkedin.com"
        #         ];
        #
        #         binde = [
        #                 "SUPER SHIFT, O, resizeactive, -10 0"
        #                 "SUPER SHIFT, E, resizeactive, 10 0"
        #                 "SUPER SHIFT, J, resizeactive, 0 10"
        #                 "SUPER SHIFT, K, resizeactive, 0 -10"
        #                 "SUPER, COMMA, workspace, -1"
        #                 "SUPER, PERIOD, workspace, +1"
        #         ];
        #
        #         bindm = [
        #                 "SUPER, mouse:272, movewindow"
        #                 "SUPER, mouse:273, resizewindow"
        #         ];
        #
        #         bindl = [
        #                 ", XF86AudioNext, exec, playerctl next"
        #                 ", XF86AudioPause, exec, playerctl play-pause"
        #                 ", XF86AudioPlay, exec, playerctl play-pause"
        #                 ", XF86AudioPrev, exec, playerctl previous"
        #         ];
        #
        #         bindel = [
        #                 ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        #                 ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        #                 ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle" 
        #                 ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        #                 ",XF86MonBrightnessUp, exec, brightnessctl s 5%+"
        #                 ",XF86MonBrightnessDown, exec, brightnessctl s 5%-"
        #         ];
        #
        #         # others
        #         misc = {
        #                 force_default_wallpaper = 1;
        #                 disable_hyprland_logo = true;
        #         };
        #
        #         input = {
        #                 kb_layout = "us";
        #                 kb_variant = "dvorak";
        #                 kb_model = "";
        #                 kb_options = "";
        #                 kb_rules = "";
        #                 follow_mouse = 1;
        #                 sensitivity = 0.3;
        #                 touchpad.natural_scroll = false;
        #         };
        #
        #         gestures.workspace_swipe = true;
        # };
        #
        # wayland.windowManager.hyprland.extraConfig = ''
        #         windowrule = suppressevent maximize, class:.*
        #         windowrule = nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0
        #
        #         windowrulev2 = noborder, class:^(kitty)$, workspace:1
        #         windowrulev2 = rounding 0, class:^(kitty)$, workspace:1
        #         windowrulev2 = rounding 2, floating:1
        #         windowrulev2 = float, class:^(feh)$
        #         windowrulev2 = float, class:^(fdm)$
        #         windowrulev2 = float, class:^(wev)$
        #         windowrulev2 = float, class:^(org.kde.dolphin)$
        #         windowrulev2 = size 1366 768, class:^(org.kde.dolphin)$
        #         windowrulev2 = size 320 180, title:^("Copying - Dolphin")$, class:^(org.kde.dolphin)$
        #         windowrulev2 = float, title:(.*)Page(.*)
        #         windowrulev2 = float, class:^(org.pulseaudio.pavucontrol)$
        #         windowrulev2 = workspace 2, class:^(discord-stable)$
        #         windowrulev2 = workspace 2, class:^(discord)$
        #         windowrulev2 = workspace 2, class:^(zen)$
        #         windowrulev2 = noborder, class:^(steam_app_312520)$
        #         windowrulev2 = nofocus, class:^(Dunst)$
        #         windowrulev2 = pin, class:^(Dunst)$
        #         windowrulev2 = float, class:^(mpv)$, title:.*f4v.*
        #
        #         windowrulev2 = float, title:^(Picture-in-Picture)$
        #         windowrulev2 = size 320 180, title:^(Picture-in-Picture)$
        #         windowrulev2 = pin, title:^(Picture-in-Picture)$
        #         windowrulev2 = content video, title:^(Picture-in-Picture)$
        #         windowrulev2 = float, title:^(Discord Popout)$
        #         windowrulev2 = content video, title:^(Discord Popout)$
        #
        #         windowrulev2 = move 0 0       , class:^(flameshot)$, title:^(flameshot)$
        #         windowrulev2 = pin            , class:^(flameshot)$, title:^(flameshot)$
        #         windowrulev2 = fullscreenstate, class:^(flameshot)$, title:^(flameshot)$
        #         windowrulev2 = noanim         , class:^(flameshot)$, title:^(flameshot)$
        #         windowrulev2 = float          , class:^(flameshot)$
        #
        #         windowrulev2 = float   , class:^(Emulator)$
        #         windowrulev2 = noborder, class:^(Emulator)$
        #
        #         windowrulev2 = size 460 270, title:^(Heal Selection)$
        #         windowrulev2 = float, title:^(Heal Selection)$
        # '';

        services.hyprpaper.enable = true;

        services.wlsunset = {
                enable = true;
                temperature = {
                        day = 7000;
                        night = 6900;
                };
                sunrise = "06:00";
                sunset = "18:00";
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
