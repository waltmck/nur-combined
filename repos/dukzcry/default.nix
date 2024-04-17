# This file describes your repository contents.
# It should return a set of nix derivations
# and optionally the special attributes `lib`, `modules` and `overlays`.
# It should NOT import <nixpkgs>. Instead, you should take pkgs as an argument.
# Having pkgs default to <nixpkgs> is fine though, and it lets you use short
# commands such as:
#     nix-build -A mypackage

{ pkgs ? import <nixpkgs> {} }:

with pkgs;

rec {
  # The `lib`, `modules`, and `overlay` names are special
  lib = import ./lib { inherit pkgs; }; # functions
  modules = import ./modules; # NixOS modules
  overlays = ./overlays; # nixpkgs overlays

  k380-function-keys-conf = callPackage ./pkgs/k380-function-keys-conf.nix { };
  knobkraft-orm = callPackage ./pkgs/knobkraft-orm.nix { };
  realrtcw = callPackage ./pkgs/realrtcw.nix { };
  re3 = callPackage ./pkgs/re3 {};
  revc = callPackage ./pkgs/re3/revc.nix { inherit re3; };
  massdns = callPackage ./pkgs/massdns.nix {};
  wireless-regdb = callPackage ./pkgs/wireless-regdb {};
  awl = callPackage ./pkgs/awl {};
  awl-tray = callPackage ./pkgs/awl/awl-tray.nix {};
  prometheus-nut-exporter = callPackage ./pkgs/prometheus-nut-exporter.nix {};
  tun2socks = callPackage ./pkgs/tun2socks.nix {};
  cockpit-machines = callPackage ./pkgs/cockpit/machines.nix {};
  cockpit-client = callPackage ./pkgs/cockpit/client.nix {};
  libvirt-dbus = callPackage ./pkgs/libvirt-dbus.nix {};
  libidn = callPackage ./pkgs/libidn.nix {};
  gitupdate = callPackage ./pkgs/gitupdate.nix {};
  homer = callPackage ./pkgs/homer.nix {};
  gtk3-nocsd = callPackage ./pkgs/gtk3-nocsd.nix {};
  aml-upgrade-package-extract = callPackage ./pkgs/aml-upgrade-package-extract.nix {};
  dsdt = callPackage ./pkgs/dsdt.nix;
  ath10k-firmware = callPackage ./pkgs/ath10k-firmware.nix {};
  cubesuite = callPackage ./pkgs/cubesuite.nix { wrapWine = pkgs.nur.repos.lucasew.packages.wrapWine or null; };
  hostapd = callPackage ./pkgs/hostapd {};
  steamlink = callPackage ./pkgs/steamlink.nix {};
  sunshine = callPackage ./pkgs/sunshine {};
  ydcmd = callPackage ./pkgs/ydcmd.nix {};
  modplay = callPackage ./pkgs/modplay.nix {};
}
