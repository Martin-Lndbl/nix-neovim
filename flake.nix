{
  description = "Homemanager neovim module";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      homeManagerModules.default = import ./default.nix self;
      homeManagerModules.transparent = import ./default.nix
        {
          inherit self;
          vimconf = {
            colorscheme = "spacecamp_transparent";
          };
        };
    };
}
