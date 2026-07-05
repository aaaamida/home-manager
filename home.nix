{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    ./pkgs.nix
    ./programs.nix
    ./files.nix
    ./services.nix
    ./vars.nix
	];

  home = {
    username = "amida";
    homeDirectory = "/home/amida";
    stateVersion = "26.05";
    activation = {
      noctalia-shell = lib.hm.dag.entryAfter ["writeBoundary"] ''
        settings_dir="$HOME/.local/state/noctalia"
        settings_file="$settings_dir/settings.toml"
        config_dir="$HOME/.config/noctalia"
        config_link="$config_dir/settings.toml"

        mkdir -p "$settings_dir"
        mkdir -p "$config_dir"

        if [ ! -f "$settings_file" ]; then
          echo '{}' > "$settings_file"
        fi

        if [ ! -L "$config_link" ] || [ "$(readlink "$config_link")" != "$settings_file" ]; then
          rm -f "$config_link"
          ln -s "$settings_file" "$config_link"
        fi
      '';
    };
  };

  nixpkgs.config.allowUnfree = true;
	home.enableNixpkgsReleaseCheck = false;
  programs.home-manager.enable = true;
}
