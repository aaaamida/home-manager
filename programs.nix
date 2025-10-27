{ config, pkgs, inputs, fetchgit, ... }:

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

                plugins = [ ];

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
                        leptos = "cargo leptos";
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

        programs.nushell = {
                enable = true;
                extraConfig = ''
                        let carapace_completer = {|spans|
                                carapace $spans.0 nushell ...$spans | from json
                        }

                        source-env ~/.df/mocha.nu

                        $env.config = {
                                show_banner: false
                                completions: {
                                        case_sensitive: false
                                        quick: true
                                        partial: true
                                        algorithm: "fuzzy"
                                        external: {
                                                enable: true
                                                max_results: 100
                                                completer: $carapace_completer
                                        }
                                }
                        }

                        $env.config.hooks.pre_prompt = [{
                                mommy -s $env.LAST_EXIT_CODE | print
                        }]

                        $env.PROMPT_COMMAND_RIGHT = {||}
                        $env.PROMPT_COMMAND = { $"\n($env.PWD)\n" }
                        $env.PROMPT_INDICATOR = "❯ "

                        $env.config.table.mode = 'thin'

                        $env.config.buffer_editor = 'nvim'

                        alias cat = bat
                        alias hm = home-manager
                        alias hms = home-manager switch --impure
                        alias nv = nvim
                        alias lg = lazygit
                        alias reboot = sudo systemctl reboot
                        alias poweroff = sudo systemctl poweroff
                        alias alien = nix-alien
                        alias nsh = nix-shell --command "zsh; exit"
                        alias ngc = nix-collect-garbage
                        alias xopen = xdg-open
                        alias cnf = command-not-found
                        alias inx = echo $env.IN_NIX_SHELL
                        alias leptos = cargo leptos

                        zoxide init nushell | save -f ~/.zoxide.nu
                        source ~/.zoxide.nu

                        warp-cli connect | ignore

                '';
        };

        programs.carapace = {
                enable = true;
                enableNushellIntegration = true;
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
                settings = {
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

        # programs.waybar = {
        #         enable = true;
        #         systemd.enable = true;
        # };

	programs.yazi = {
		enable = true;
                enableZshIntegration = true;
	};
}
