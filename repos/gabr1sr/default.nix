# This file describes your repository contents.
# It should return a set of nix derivations
# and optionally the special attributes `lib`, `modules` and `overlays`.
# It should NOT import <nixpkgs>. Instead, you should take pkgs as an argument.
# Having pkgs default to <nixpkgs> is fine though, and it lets you use short
# commands such as:
#     nix-build -A mypackage

{ pkgs ? import <nixpkgs> { } }:

{
  # The `lib`, `modules`, and `overlay` names are special
  lib = import ./lib { inherit pkgs; }; # functions
  modules = import ./modules; # NixOS modules
  overlays = import ./overlays; # nixpkgs overlays

  vscode-solidity-server = pkgs.callPackage ./pkgs/vscode-solidity-server { };
  starknet-foundry-bin = pkgs.callPackage ./pkgs/starknet-foundry-bin { };
  scarb-bin = pkgs.callPackage ./pkgs/scarb-bin { };
  huff = pkgs.callPackage ./pkgs/huff { };
  halmos = pkgs.python3.pkgs.callPackage ./pkgs/halmos { };
  # some-qt5-package = pkgs.libsForQt5.callPackage ./pkgs/some-qt5-package { };
  # ...
}
