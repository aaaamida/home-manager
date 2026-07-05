{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    quickshell = {
      url = "github:outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
      # inputs.quickshell.follows = "quickshell";
    };

    nixcord.url = "github:4evy/nixcord";
    krisp-patcher.url = "git+https://git.gay/amida/krisp-patcher";
    kira-studio.url = "git+https://git.gay/amida/kira-studio-flake";
    zhao-cur.url = "git+ssh://git@git.gay/amida/zhao-cur";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }: {
    homeConfigurations = {
      "amida" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { system = "x86_64-linux"; };
        extraSpecialArgs = { inherit inputs; };
        modules = [ ./home.nix ];
      };
    };
  };
}
