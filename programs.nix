{ config, pkgs, inputs, ... }:

{
        programs.zsh = {
                enable = true;
                enableCompletion = true;
                autosuggestion.enable = true;
                syntaxHighlighting.enable = true;

                oh-my-zsh = {
                        enable = true;
                        plugins = [
                                "sudo" "safe-paste" "git"
                                "zoxide" "zsh-interactive-cd"
                        ];
                        theme = "refined";
                };

                plugins = [
                        # {
                        #         name = "nix-shell";
                        #         file = "nix-shell.plugin.zsh";
                        #         src = pkgs.fetchFromGitHub {
                        #                 owner = "chisui";
                        #                 repo = "zsh-nix-shell";
                        #                 rev = "v0.8.0";
                        #                 sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
                        #         };
                        # }
                ];

                shellAliases = {
                        ls = "eza -laTL 2 --git --git-repos --icons=always --hyperlink ";
                        cp = "cp -rv ";
                        cat = "bat";
                        hm = "home-manager";
                        hms = "home-manager switch --impure";
                        nv = "nvim";
                        lg = "lazygit";
                        reboot = "sudo systemctl reboot";
                        poweroff = "sudo systemctl poweroff";
                        alien = "nix-alien";
                        nsh = "nix-shell --command 'zsh; exit'";
                        ngc = "nix-collect-garbage";
                        open = "xdg-open";
                        cnf = "command-not-found";
                        inx = "echo $IN_NIX_SHELL";
                };

                initContent = ''
                        export PATH=$PATH:$HOME/.bin:$HOME/.cargo/bin/
                        export EDITOR=nvim

                        function cargo() {
                                if [ $1 = "run" ] ||
                                [ $1 = "check" ] ||
                                [ $1 = "test" ]; then
                                        command cargo mommy "$@"
                                else
                                        command cargo "$@"
                                fi
                        }

                        eval $(zoxide init zsh)
                        eval $(fzf --zsh)
                        warp-cli connect > /dev/null
                '';

                history = {
                        size = 5000;
                        ignoreAllDups = true;
                        path = "$HOME/.zsh_history";
                };
        };

        programs.neovim = {
                enable = true;
                viAlias = true;
                vimAlias = true;
                plugins = with pkgs.vimPlugins; [
                        nvim-treesitter.withAllGrammars
                        vim-go
                ];
        };

        programs.git = {
                enable = true;
                extraConfig = {
                        diff = {
                                external = "difft";
                        };
                };
        };

        programs.helix = {
                enable = true;
                extraPackages = with pkgs; [ nil ];
        };

        programs.direnv = {
                enable = true;
                enableZshIntegration = true;
                enableBashIntegration = true;
                nix-direnv.enable = true;
        };

        programs.zed-editor = {
                enable = true;
                package = pkgs.zed-editor.fhsWithPackages (pkgs: (with pkgs; [
                        openssl
                        libz
                        nerd-fonts.iosevka-term-slab
                ]));
                # extraPackages = with pkgs; [
                #         openssl
                #         libz
                #         nerd-fonts.iosevka-term-slab
                # ];
        };

        programs.kitty.enable = true;

        programs.tmux = {
                enable = true;
                terminal = "xterm-direct";
        };

        programs.btop.enable = true;

        programs.rofi = {
                enable = true;
                theme = /home/amida/.df/hypr/rofi/themes/dmenu.rasi;
        };

        programs.waybar = {
                enable = true;
                systemd.enable = true;
        };

	programs.yazi = {
		enable = true;
                enableZshIntegration = true;
	};
}
