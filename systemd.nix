{ config, pkgs, ... }:

{
        # systemd.user.services.mpvpaper-autostart = {
        #         Unit = {
        #                 Description = "Autostart mpvpaper.";
        #                 PartOF = [ "graphical-session.target" ];
        #                 After = [ "graphical-session.target" ];
        #         };
        #         Install = {
        #                 WantedBy = [ "graphical-session.target" ];
        #         };
        #         Service = {
        #                 ExecStart = "${pkgs.writeShellScript "mpvpaper-autostart" ''
        #                         #!/run/current-system/sw/bin/bash
        #                         ${pkgs.mpvpaper}/bin/mpvpaper -o "no-audio loop" eDP-1 /home/amida/Pictures/gyr_up.mp4
        #                 ''}";
        #                 Restart = "on-failure";
        #         };
        # };
}
