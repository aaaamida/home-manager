{ config, pkgs, inputs, ... }:

{
        home.packages = with pkgs; [
                lazygit
                gh
                btop
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
        ];
}
