{ config, pkgs, inputs, ... }:

{
	imports = [
		./pkgs.nix
		./programs.nix
	];

        home = {
                username = "amida";
                homeDirectory = "/home/amida";
                stateVersion = "25.05";
        };

        nixpkgs.config.allowUnfree = true;
	home.enableNixpkgsReleaseCheck = false;
        programs.home-manager.enable = true;
}
