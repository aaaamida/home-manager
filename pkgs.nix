{ config, pkgs, inputs, ... }:
let
        zen-browser = (builtins.getFlake https://github.com/0xc000022070/zen-browser-flake/tarball/master).packages.x86_64-linux.default;
in
{
        home.packages = with pkgs; [
                zen-browser
                lazygit
                gh
                fastfetch
                hyfetch
                rustup
                clang
                python314
                libgcc
                discord
                youtube-music
                yt-dlp
                betterdiscordctl
                cloudflare-warp
                appimage-run
                gnumake
                cmake
                zoxide
                fzf
                bat
                eza
                nerd-fonts.iosevka-term-slab
        ];
}
