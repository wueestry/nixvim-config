{
  description = "A nixvim configuration";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";

    nixvim.url = "github:nix-community/nixvim";

    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixvim,
    flake-utils,
    pre-commit-hooks,
    ...
  } @ inputs: let
    config = import ./config; # import the module directly
  in
    flake-utils.lib.eachDefaultSystem (system: let
      nixvimLib = nixvim.lib.${system};
      pkgs = import nixpkgs {inherit system;};
      nixvim' = nixvim.legacyPackages.${system};
      nvim = nixvim'.makeNixvimWithModule {
        inherit pkgs;
        module = config;
      };
    in {
      formatter = nixpkgs.legacyPackages.${system}.nixpkgs-fmt;

      checks = {
        default = nixvimLib.check.mkTestDerivationFromNvim {
          inherit nvim;
          name = "My nixvim configuration";
        };
	pre-commit-check = pre-commit-hooks.lib.${system}.run {
          src = ./.;
            hooks = {
              alejandra.enable = true;
            };
	};
      };

      packages = {
        # Lets you run `nix run .` to start nixvim
        default = nvim;
      };

      devShells.${system} = {
          default = pkgs.mkShell {
            inherit (self.checks.${system}.pre-commit-check) shellHook;
            buildInputs = with pkgs; [
              alejandra
            ];
          };
        };
    });
}
