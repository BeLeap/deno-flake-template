{
  pkgs ? import <nixpkgs> { },
}:
pkgs.stdenv.mkDerivation {
  name = "example";

  src = ./.;

  nativeBuildInputs = with pkgs; [
    deno
  ];

  buildPhase = ''
    DENO_DIR=$TMP/deno deno compile -A -o example $src/main.ts
  '';

  installPhase = ''
    mkdir -p $out/bin
    install -m755 example $out/bin/example
  '';
}
