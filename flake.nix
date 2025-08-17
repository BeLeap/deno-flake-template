{
  description = "Deno flake template";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    (builtins.foldl'
      (
        acc: system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        (
          acc
          // {
            packages.${system}.default = import ./default.nix { inherit pkgs; };
            devShells.${system}.default = import ./shell.nix { inherit pkgs; };
          }
        )
      )
      { }
      [
        "x86_64-linux"
        "aarch64-darwin"
      ]
    );
}
