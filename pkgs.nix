{ config, pkgs, inputs, ... }:
let
        zen-browser = (builtins.getFlake https://github.com/0xc000022070/zen-browser-flake/tarball/master).packages.x86_64-linux.default;
        freedownloadmanager = import (pkgs.fetchFromGitHub {
                owner = "aaaamida";
                repo = "nix-fdm";
                rev = "master";
                hash = "sha256-QYIM2bcK9WOhvbjZ8REHAdwbWLTz9fEh+34ssPM3j4Q=";
        }) {};
in
{
        home.packages = with pkgs; [
                # GUI programs
                zen-browser
                discord
                youtube-music
                freedownloadmanager

                # CLI utils
                lazygit
                fzf
                gh
                fastfetch
                hyfetch
                yt-dlp
                betterdiscordctl
                appimage-run
                zoxide
                bat
                eza
                fd

                # PL tools
                rustup
                clang
                python314
                libgcc
                gnumake
                cmake

                # misc
                nerd-fonts.iosevka-term-slab
        ];
}
