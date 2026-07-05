{ config, pkgs, ... }:
let
  file = builtins.readFile;
in
{
  xdg.configFile = {
    neovim = {
      recursive = true;
      source = /home/amida/.df/nvim;
      target = "nvim";
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

    "flameshot/flameshot.ini".text = ''
      [General]
      autoCloseIdleDaemon=true
      buttons=@Variant(\0\0\0\x7f\0\0\0\vQList<int>\0\0\0\0\0)
      contrastOpacity=153
      drawColor=#00ff00
      reverseArrow=true
      saveAfterCopy=true
      saveLastRegion=false
      savePath=/home/amida/Pictures/Screenshots
      startupLaunch=false
      uiColor=#ffa4a5
      useGrimAdapter=true
      userColors=picker, #800000, #ff0000, #ffff00, #00ff00, #008000, #00ffff, #0000ff, #ff00ff, #800080, #ffaeae
      disabledGrimWarning=true
    '';

    "aria2/aria2.conf".text = ''
      dir=/home/amida/Downloads/aria2/
      enable-rpc=true
      rpc-listen-all=false
      log=/home/amida/.aria2.log
      daemon=true
    '';
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
      "application/vnd.openxmlformats-officedocument.presentationml.presentation"   = "${pkgs.libreoffice-qt6-fresh}/share/applications/impress.desktop";
      "application/vnd.openxmlformats-officedocument.wordprocessingml.presentation" = "${pkgs.libreoffice-qt6-fresh}/share/applications/writer.desktop";
      # "x-scheme-handler/fdm"     = "freedownloadmanager_fdm_up.desktop";
      # "x-scheme-handler/magnet"  = "freedownloadmanager_fdm_magnet_up.desktop";
      # "application/x-bittorrent" = "freedownloadmanager_torrent.desktop";
    };

    associations.added = {
      "x-scheme-handler/http"   = [ "zen-beta.desktop" "userapp-Zen-SE40C3.desktop" ];
      "x-scheme-handler/https"  = [ "zen-beta.desktop" "userapp-Zen-SE40C3.desktop" ];
      "x-scheme-handler/chrome"       = [ "zen-beta.desktop" "userapp-Zen-SE40C3.desktop" ];
      "text/html"         = [ "zen-beta.desktop" "userapp-Zen-SE40C3.desktop" ];
      "application/x-extension-htm"   = [ "zen-beta.desktop" "userapp-Zen-SE40C3.desktop" ];
      "application/x-extension-html"  = [ "zen-beta.desktop" "userapp-Zen-SE40C3.desktop" ];
      "application/x-extension-shtml" = [ "zen-beta.desktop" "userapp-Zen-SE40C3.desktop" ];
      "application/xhtml+xml"   = [ "zen-beta.desktop" "userapp-Zen-SE40C3.desktop" ];
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

    # zzz = {
    #   name = "Zenless Zone Zero";
    #   exec = "umu-run /home/amida/Games/ZZZ.exe %f";
    #   terminal = false;
    #   categories = [ "Game" ];
    # };
  };

}
