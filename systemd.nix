{ config, pkgs, ... }:

{
        services = {
                tomat.enable = true;
                ollama.enable = true;
        };
}
