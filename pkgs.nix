{ config, pkgs, inputs, ... }:
let
  system = pkgs.stdenv.hostPlatform.system;

  zen-browser = (builtins.getFlake https://github.com/0xc000022070/zen-browser-flake/tarball/master).packages.x86_64-linux.default;
  # ags = (builtins.getFlake https://github.com/aylur/ags/tarball/master).packages.x86_64-linux.default;
  orange3 = (builtins.getFlake https://github.com/scuggo/orange3-nix-fix/tarball/master).packages.x86_64-linux.default;
  alien = import (builtins.fetchTarball https://github.com/thiagokokada/nix-alien/tarball/master) {};

  kopuz         = inputs.kopuz.packages.${system}.default;
  krisp-patcher = inputs.krisp-patcher.packages.${system}.default;
  helium        = inputs.helium.packages.${system}.default;
  kira-studio   = inputs.kira-studio.packages.${system}.default;
  zhao-cur      = inputs.zhao-cur.packages.${system};

  gallery-dl = pkgs.gallery-dl.overrideAttrs (old: {
    src = pkgs.fetchFromGitHub {
      owner = "mikf";
      repo  = "gallery-dl";
      rev   = "master";
      hash  = "sha256-37P5rql9yf0pnDdmI254y2nBATjNyoR2sDGUJdTHyUg=";
    };
  });
in
{
  home.packages = with pkgs; [
    # GUI apps
    zen-browser
    helium
    discord
    feh
    mpv
    libreoffice-qt6-fresh
    zathura
    orange3
    qbittorrent-enhanced
    vesktop
    kira-studio
    teamviewer
    gimp
    thunderbird
    (youtube-music.overrideAttrs (old: {
      meta = old.meta // { mainProgram = "youtube-music"; };
    }))
    karere
    pinta
    # kopuz

    # CLI utils
    lazygit
    fzf
    gh
    fastfetch
    hyfetch
    yt-dlp
    gallery-dl
    betterdiscordctl
    appimage-run
    zoxide
    bat
    eza
    fd
    p7zip
    unzip
    unrar
    asciiquarium
    libnotify
    ripgrep
    killall
    playerctl
    opencode
    file
    krisp-patcher
    ookla-speedtest
    ffmpeg
    jmtpfs
    jq
    difftastic
    nix-index
    mpg123
    timg
    sqlite-interactive
    # oxicord
    android-tools
    adbfs-rootless
    aria2
    # kubernetes
    k3s

    # PL tools
    rustup
    clang
    rust-script
    python314
    typst
    nil
    nixd
    zig

    # wm
    wl-clipboard
    wl-clipboard-x11
    xdg-desktop-portal-hyprland
    hyprcursor
    hyprpaper
    hyprshot
    hypridle
    # flameshot
    wev
    mpvpaper
    wlsunset
    brightnessctl
    nwg-displays
    quickshell
    hyprsunset
    xwayland-satellite
    wl-mirror
    # niri

    # misc
    zhao-cur.hyprcursor
    zhao-cur.xcursor
    sshfs
    # winboat
    # freerdp
    music-discord-rpc
    cava
    bluetuith
    papirus-icon-theme
    pavucontrol
    usbutils
    bluez
    amdgpu_top
    nvtopPackages.amd
    docker
    wineWow64Packages.full
    umu-launcher
    # (lutris.override {
    #   extraLibraries = pkgs: [ libadwaita ];
    # })
  ]
  ++ [ alien.nix-alien ]
  ++ (with kdePackages; [
    filelight
    qt6ct
    kdenlive
  ])
  ++ (with python313Packages; [
    ds4drv
    # truststore
    # orange3
  ]);
}
