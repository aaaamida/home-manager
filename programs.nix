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
                        hms = "home-manager switch --impure";
			nv = "nvim";
                        lg = "lazygit";
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

        programs.neovim = {
                enable = true;
                viAlias = true;
                vimAlias = true;
        };

        programs.kitty.enable = true;

        programs.tmux = {
                enable = true;
                terminal = "screen-256color";
        };

        programs.btop.enable = true;

	programs.yazi = {
		enable = true;
                enableZshIntegration = true;
	};
}
