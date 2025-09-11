# packages w configs go here

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
                        hms = "home-manager switch --flake /home/amida/.hm/ --impure";
                        nvim = "/home/amida/.bin/nvim";
			nv = "nvim";
                };

                initContent = ''
                        source ~/.extra.zsh
                '';

                history = {
                        size = 5000;
                        ignoreAllDups = true;
                        path = "$HOME/.zsh_history";
                };
        };

        #programs.neovim = {
        #       enable = true;
        #        viAlias = true;
        #        vimAlias = true;
        #        extraConfig = builtins.readFile /home/amida/.df/nvim/init.lua;
        #};

        programs.kitty = {
                enable = true;
                extraConfig = builtins.readFile ~/.config/kitty/main.conf;
        };

        programs.tmux = {
                enable = true;
                terminal = "screen-256color";
                extraConfig = builtins.readFile /home/amida/.config/tmux/main.conf;
        };

        programs.btop = {
                enable = true;
                extraConfig = builtins.readFile /home/amida/.config/btop/main.conf;
                themes = {
                        pastelbian = builtins.readFile /home/amida/.config/btop/themes/custom.theme;
                };
        };

	programs.yazi = {
		enable = true;
	};
}
