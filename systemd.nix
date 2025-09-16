{}:
let
        wallpaper = /home/amida/Pictures/gyr_up.mp4;
in
{
        systemd.user.services.mpvpaper-autostart = {
                Unit = {
                        Description = "Autostart mpvpaper.";
                };
                Install = {
                        WantedBy = [ "default.target" ];
                };
                Service = {
                        ExecStart = "${pkgs.writeShellScript "mpvpaper-autostart" ''
                                #!/run/current-system/sw/bin/bash
                                ${pkgs.mpvpaper}/bin/mpvpaper -o "no-audio loop" eDP-1 ${wallpaper}
                        ''}";
                };
        };
}
