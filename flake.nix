{
  description = "jimnazeum app";
  inputs = {
    devshell.url = "github:numtide/devshell";
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/release-22.11";
  };
  outputs =
    inputs@{ self
    , devshell
    , flake-utils
    , nixpkgs
    }: flake-utils.lib.eachDefaultSystem (system:
    let
      project = "jimnazeum";
      pkgs = import nixpkgs { inherit system; overlays = [ devshell.overlay ]; };
      inherit (pkgs.devshell) mkShell;
    in
    rec {
      devShell = mkShell {
        name = "${project}-shell";
        commands = [{ package = "devshell.cli"; }];
        packages = with pkgs; [
          gitleaks
          go
          nixpkgs-fmt
          pre-commit
        ];
      };
    }
    );
}
