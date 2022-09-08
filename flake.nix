{
  description = "Minimal reproducible example for clippy and rustfmt nix pre commit hooks";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/master";
    naersk.url = "github:nix-community/naersk";
    utils.url = "github:numtide/flake-utils";
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
  };

  outputs = { self, nixpkgs, utils, naersk, pre-commit-hooks }:
    utils.lib.eachSystem [ utils.lib.system.x86_64-linux ] (system:
      let
        rustfmtHook = pre-commit-hooks.lib.${system}.run {
          src = ./.;
          hooks = {
            rustfmt.enable = true;
            clippy.enable = true;
          };
        };
      in {
        checks = {
          inherit rustfmtHook;
        };
        defaultApp = rustfmtHook;
      }
  );
}

