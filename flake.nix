{
  description = "Gleam Web Development";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?rev=032bc6539bd5f14e9d0c51bd79cfe9a055b094c3";
    flake-utils.url = "github:numtide/flake-utils?rev=11707dc2f618dd54ca8739b309ec4fc024de578b";
  };
  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { };
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            # erlang
            pkgs.erlang_28
            pkgs.beamMinimal27Packages.rebar3

            # gleam
            pkgs.gleam

            # tailwind
            pkgs.tailwindcss_4
          ];
          shellHook = "";
        };
      }
    );
}
