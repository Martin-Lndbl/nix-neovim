{ pkgs, lib, config, ... }:

let
  cfg = config.programs.neovim.baseConfiguration;
in
with lib;
{
  options.programs.neovim.baseConfiguration = {
    enable = mkEnableOption "Use preconfigured neovim";
    leader = mkOption {
      description = "Custom mapleader";
      type = types.str;
      default = ",";
    };
    colorscheme = mkOption {
      description = "Vim colorscheme";
      type = types.str;
      default = "base16-colorscheme";
      example = "spacecamp_transparent";
    };
  };
  config = mkIf cfg.enable
    {
      programs.neovim = import ./baseConfiguration { inherit pkgs config lib; };
    };
}

