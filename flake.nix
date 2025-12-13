{
        description = "A very basic flake";

        inputs = {
                nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
                home-manager = {
                        url = "github:nix-community/home-manager";
                        inputs.nixpkgs.follows = "nixpkgs";
                };
                # zen-browser = {
                #         url = "github:0xc000022070/zen-browser-flake";
                #         inputs.nixpkgs.follows = "nixpkgs";
                # };
                quickshell = {
                        url = "github:outfoxxed/quickshell";
                        inputs.nixpkgs.follows = "nixpkgs";
                };
                noctalia = {
                        url = "github:noctalia-dev/noctalia-shell";
                        inputs.nixpkgs.follows = "nixpkgs";
                        # inputs.quickshell.follows = "quickshell";
                };
                yt-dlp.url = "github:aaaamida/yt-dlp-flake";
                freedownloadmanager.url = "github:aaaamida/nix-fdm";
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
