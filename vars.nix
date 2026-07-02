{ configs, pkgs, inputs, ... }:

{
  home.sessionVariables = {
    EDITOR = "nvim";
    XDG_CONFIG_HOME = "/home/amida/.config";
  };
}
