{
  inputs = {
    systems.url = "github:nix-systems/default";
    nixpkgs.url = "github:NixOS/nixpkgs/ae8a436bc79e20e05d16f4df99aae01527602f0f";
    devenv.url = "github:cachix/devenv/v0.6.3";
  };
  outputs = { self, nixpkgs, devenv, systems, ... } @ inputs:
    let
      forEachSystem = nixpkgs.lib.genAttrs (import systems);
    in
    {
      devShells = forEachSystem
        (system:
          let
            pkgs = nixpkgs.legacyPackages.${system};
          in
          {
            default = devenv.lib.mkShell {
              inherit inputs pkgs;
              modules = [
                ({ pkgs, ... }: {
                  packages = [
                  
                    # Basic Utilities
                    pkgs.inotify-tools

                    # Elixir
                    pkgs.elixir_ls

                  ];

                  enterShell = ''
                    mix archive.install hex mix_gleam --force > /dev/null
                    mix deps.get > /dev/null
                    devenv up > /dev/null &
                  '';

                  languages.elixir = {
                    enable = true;
                    package = pkgs.elixir_1_16;
                  };

                  languages.gleam = {
                    enable = true;
                    package = pkgs.gleam;
                  };
                })
              ];
            };
          });
    };
}
