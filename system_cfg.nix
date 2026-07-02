{ config, pkgs, ... }:

{
  # imports = [
  #   ./hardware-configuration.nix
  # ];

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    loader = {
      systemd-boot.enable = false;
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        device = "nodev";
        useOSProber = true;
        efiSupport = true;
      };
    };
    kernelModules = [ "thunderbolt" ];
  };

  networking = {
    hostName = "yuri";
    networkmanager.enable = true;
    firewall.allowedTCPPorts = [ 5243 6747 ];
  };

  time.timeZone = "Asia/Makassar";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocales = [ "ja_JP.UTF-8/UTF-8" ];
    inputMethod = {
      type = "fcitx5";
      enable = true;
      fcitx5 = {
        waylandFrontend = true;
        addons = with pkgs; [
          fcitx5-mozc
          fcitx5-rose-pine
          kdePackages.fcitx5-qt
        ];
      };
    };
  };

  security.rtkit.enable = true;

  services = {
    hardware.bolt.enable = true;
    cloudflare-warp.enable = true;
    displayManager.sddm.enable = true;
    flatpak.enable = false;
    power-profiles-daemon.enable = true;
    tailscale.enable = true;
    printing.enable = true;
    openssh.enable = true;

    desktopManager = {
      plasma6.enable = true;
      cosmic.enable = true;
    };

    xserver = {
      enable = true;
      desktopManager.runXdgAutostartIfNone = true;
      xkb = {
        layout = "us";
        variant = "dvorak";
      };
    };

    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
  };

  console.keyMap = "dvorak";
  fonts.packages = with pkgs; [
    noto-fonts-cjk-serif
    corefonts
  ];

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Plugins = "a2dp,avcrp,hfp";
        Privacy = "device";
        JustWorksRepairing = "always";
        FastConnectable = true;
      };
    };

  users.users.amida = {
    isNormalUser = true;
    description = "Amida";
    extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" ];
  	shell = pkgs.zsh;
    packages = with pkgs; [ ];
  };

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
      };
    };

    docker = {
      enable = true;
      enableOnBoot = false;
    };
  };

  programs = {
    firefox.enable = true;
    command-not-found.enable = true;
    tmux.enable = true;
    git.enable = true;
    steam.enable = true;
    gamemode.enable = true;
    virt-manager.enable = true;
    fuse.userAllowOther = true;
    niri.enable = true;

    appimage = {
      enable = true;
      binfmt = true;
      package = (pkgs.appimage-run.override {
        extraPkgs = pkgs: [ pkgs.icue ];
      });
    };

    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        stdenv.cc.cc.lib
        openssl
        zlib
        libxkbcommon
        wayland
        vulkan-loader
        fontconfig
        freetype
      ] ++ (with xorg; [
        libX11
        libXcursor
        libXrandr
        libXi
      ]);
    };

    zsh = {
      enable = true;
      interactiveShellInit = ''
        if ! [ "$TERM" = "dumb" ]; then
          exec nu
        fi
      '';
    };

    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      configure.customRC = "set tabstop=2 shiftwidth=2 rnu number expandtab";
    };

    hyprland = {
      enable = false;
      xwayland.enable = true;
    };
  };

  environment = {
    systemPackages = with pkgs; [
      nh
      vim
      wget
      kitty
      vulkan-tools
      alsa-tools
      nerd-fonts.iosevka-term-slab
    ];

    shells = [ pkgs.nushell ];

    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ "@wheel" ];
  };

  system.stateVersion = "25.05";

}
