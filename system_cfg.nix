{ config, pkgs, ... }:

{
        # imports = [
        #         ./hardware-configuration.nix
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
                hypridle.enable = false;
                tailscale.enable = true;
                printing.enable = true;

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

                tlp = {
                        enable = false;
                        settings = {
                                START_CHARGE_THRESH_BAT0 = 50;
                                STOP_CHARGE_THRESH_BAT0  = 90;
                        };
                };
        };

        console.keyMap = "dvorak";
        fonts.packages = with pkgs; [
                noto-fonts-cjk-serif
        ];

        hardware.bluetooth.enable = true;

        users.users.amida = {
                isNormalUser = true;
                description = "Amida";
                extraGroups = [ "networkmanager" "wheel" "docker" ];
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
                fuse.userAllowOther = true;

                appimage = {
                        enable = true;
                        binfmt = true;
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
                        configure.customRC = "set tabstop=8 shiftwidth=8 rnu number expandtab";
                };

                hyprland = {
                        enable = true;
                        xwayland.enable = true;
                };
        };

        environment = {
                etc.neovim = {
                        source = /home/amida/.df/nvim;
                        target = "nvim";
                };

                systemPackages = with pkgs; [
                        nh
                        vim
                        wget
                        kitty
                        vulkan-tools
                        alsa-tools
                        nerd-fonts.iosevka-term-slab
                        (catppuccin-sddm.override {
                                flavor = "mocha";
                                font = "IosevkaTermSlab Nerd Font";
                                fontSize = "12";
                                background = "${/home/amida/Pictures/sddm.png}";
                                loginBackground = true;
                        })
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
