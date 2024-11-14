{
  pkgs ? import <nixpkgs> {}
}:
pkgs.mkShellNoCC {
  packages = with pkgs; [
    m4
  ];
}
