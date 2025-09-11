{
        description = "A very basic flake";

        inputs = {
                nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
                home-manager = {
                        url = "github:nix-community/home-manager";
                        inputs.nixpkgs.follows = "nixpkgs";
                };
                zen-browser = {
                        url = "github:0xc000022070/zen-browser-flake";
                        inputs.nixpkgs.follows = "nixpkgs";
                };
        };

        outputs = { self, nixpkgs, home-manager, ... }@inputs: {
                homeConfigurations = {
                        "amida" = home-manager.lib.homeManagerConfiguration {
                                pkgs = import nixpkgs { system = "x86_64-linux"; };
                                modules = [ ./home.nix ];
                        };
                };
        };
}
