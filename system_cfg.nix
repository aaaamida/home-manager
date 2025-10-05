{ config, pkgs, ... }:

{
        # imports = [
        #         ./hardware-configuration.nix
        # ];

        boot.kernelPackages = pkgs.linuxPackages_zen;
        boot.loader = {
                systemd-boot.enable = false;
                efi.canTouchEfiVariables = true;
                grub = {
                        enable = true;
                        device = "nodev";
                        useOSProber = true;
                        efiSupport = true;
                };
        };

        networking.hostName = "yuri";
        networking.networkmanager.enable = true;

        time.timeZone = "Asia/Makassar";

        i18n.defaultLocale = "en_US.UTF-8";

        services.xserver.enable = false;

        services.cloudflare-warp.enable = true;

        services.displayManager.sddm.enable = true;
        services.desktopManager.plasma6.enable = true;

        services.xserver.xkb = {
                layout = "us";
                variant = "dvorak";
        };

        console.keyMap = "dvorak";

        services.printing.enable = true;

        services.pulseaudio.enable = false;
        security.rtkit.enable = true;
        services.pipewire = {
                enable = true;
                alsa.enable = true;
                alsa.support32Bit = true;
                pulse.enable = true;
                wireplumber.enable = true;
        };
        services.flatpak.enable = true;
        services.power-profiles-daemon.enable = true;
        services.hypridle.enable = true;

        fonts.packages = with pkgs; [
                noto-fonts-cjk-serif
        ];

        hardware.bluetooth.enable = true;

        users.users.amida = {
                isNormalUser = true;
                description = "Amida";
                extraGroups = [ "networkmanager" "wheel" ];
		shell = pkgs.zsh;
                packages = with pkgs; [
                        kdePackages.kate
                ];
        };

        programs.nix-ld.enable = true;
        programs.firefox.enable = true;
        programs.tmux.enable = true;
        programs.git.enable = true;
        programs.zsh.enable = true;
        programs.neovim = {
                enable = true;
                viAlias = true;
                vimAlias = true;
                configure.customRC = "set tabstop=8 shiftwidth=8 rnu number expandtab";
        };
        programs.hyprland = {
                enable = true;
                xwayland.enable = true;
        };
        programs.steam.enable = true;
        programs.fuse.userAllowOther = true;

        environment.etc.neovim = {
                source = /home/amida/.df/nvim;
                target = "nvim";
        };

        nixpkgs.config.allowUnfree = true;

        environment.systemPackages = with pkgs; [
                vim
                wget
                kitty
                vulkan-tools
                nerd-fonts.iosevka-term-slab
        ];

        nix.settings.experimental-features = [ "nix-command" "flakes" ];

        system.stateVersion = "25.05";

}
