{ config, pkgs, ... }:

{
  services = {
    tomat.enable = true;
    ollama.enable = true;
    easyeffects.enable = true;

    cliphist = {
      enable = true;
      allowImages = true;
    };

    rescrobbled = {
      enable = true;
      settings = {
        lastfm-key = builtins.readFile /home/amida/.lastfm-key;
        lastfm-secret = builtins.readFile /home/amida/.lastfm-secret;
        min-play-time = 40;
        player-whitelist = [ "elisa" "chromium.*" ];
      };
    };
    # flameshot.enable = true;
  };

  systemd.user.services = {
    # qbittorrent = {
    #   Unit = {
    #     Description = "qBittorrent";
    #     After = [ "graphical-session-pre.target" ];
    #     PartOf = [ "graphical-session.target" ];
    #   };
    #
    #   Service = {
    #     ExecStart = "${pkgs.qbittorrent-enhanced}/bin/qbittorrent";
    #     Restart = "on-failure";
    #     RestartSec = 5;
    #   };
    #
    #   Install.WantedBy = [ "graphical-session.target" ];
    # };
  };
}
