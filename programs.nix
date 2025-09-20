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

                shellAliases = {
                        ls = "eza -laTL 2 --git --git-repos --icons=always --hyperlink ";
                        cat = "bat";
                        hm = "home-manager";
                        hms = "home-manager switch --impure";
                        nv = "nvim";
                        lg = "lazygit";
                        reboot = "sudo systemctl reboot";
                        poweroff = "sudo systemctl poweroff";
                        alien = "nix-alien";
                        nsh = "nix-shell --command 'zsh'";
                        ngc = "nix-collect-garbage";
                        open = "xdg-open";
                };

                initContent = ''
                        export PATH=$PATH:$HOME/.bin:$HOME/.cargo/bin/

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
                plugins = [
                        pkgs.vimPlugins.nvim-treesitter.withAllGrammars
                ];
        };

        programs.helix = {
                enable = true;
                extraPackages = with pkgs; [ nil ];
        };

        programs.zed-editor.enable = true;

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
