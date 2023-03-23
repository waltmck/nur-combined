{ pkgs ? import <nixpkgs> {} }:

let
  callPackage = pkgs.newScope self;
  self = rec {

    #32bit
    callPackage_i686  = pkgs.lib.callPackageWith (pkgs.pkgsi686Linux // self);

    hl4150cdn         = callPackage_i686 ./drivers/hl4150cdn                     { };

    crelease          = pkgs.callPackage ./utils/crelease                        { };
    cryptobox         = pkgs.callPackage ./utils/cryptobox                       { };

    gnome-screenshot  = pkgs.callPackage ./patched-software/gnome-screenshot     { };

    fred              = pkgs.callPackage ./pims-projects/fred                    { };
    embgit            = pkgs.callPackage ./pims-projects/embgit                  { };
    mip-crystal       = pkgs.callPackage ./pims-projects/mip-crystal             { };
    mip-rust          = pkgs.callPackage ./pims-projects/mip-rust                { };

    gnomeExtensions.gs-git   = pkgs.callPackage ./gnome-shell-extensions/gs-git         { };
    gnomeExtensions.vitals   = pkgs.callPackage ./gnome-shell-extensions/vitals         { };

  };
in self
