# This file was generated by GoReleaser. DO NOT EDIT.
# vim: set ft=nix ts=2 sw=2 sts=2 et sta
{
system ? builtins.currentSystem
, pkgs
, lib
, fetchurl
, installShellFiles
}:
let
  shaMap = {
    i686-linux = "16gl15n0vp8vbf8c4mxi0h6ffxhqsrmkrcdwp808zk2vzlxmjp62";
    x86_64-linux = "1w8l03rfqh5k78al3c0z1inx504niisa6hlsa61g7nxsr9c3q8d7";
    armv7l-linux = "11s85ydiq45g5gwa37qclydz0sf77b4d7wlralpc7j5z9bvy5n4s";
    aarch64-linux = "1h3m94f3p4byi03ppmz8g9zsyk1jksz26sp7yhzcq8dxzij1pamh";
    x86_64-darwin = "03q6lxxyfiyakncpf4v9ii23mf214inhnqmbkjrrjbqmgv9qvm1d";
    aarch64-darwin = "12kiaqkmzvx92xa1cl5i12n33gk9xckhq828v9ckdqllnnnl59nv";
  };

  urlMap = {
    i686-linux = "https://github.com/goreleaser/goreleaser/releases/download/v1.21.0/goreleaser_Linux_i386.tar.gz";
    x86_64-linux = "https://github.com/goreleaser/goreleaser/releases/download/v1.21.0/goreleaser_Linux_x86_64.tar.gz";
    armv7l-linux = "https://github.com/goreleaser/goreleaser/releases/download/v1.21.0/goreleaser_Linux_armv7.tar.gz";
    aarch64-linux = "https://github.com/goreleaser/goreleaser/releases/download/v1.21.0/goreleaser_Linux_arm64.tar.gz";
    x86_64-darwin = "https://github.com/goreleaser/goreleaser/releases/download/v1.21.0/goreleaser_Darwin_x86_64.tar.gz";
    aarch64-darwin = "https://github.com/goreleaser/goreleaser/releases/download/v1.21.0/goreleaser_Darwin_arm64.tar.gz";
  };
in
pkgs.stdenv.mkDerivation {
  pname = "goreleaser";
  version = "1.21.0";
  src = fetchurl {
    url = urlMap.${system};
    sha256 = shaMap.${system};
  };

  sourceRoot = ".";

  nativeBuildInputs = [ installShellFiles ];

  installPhase = ''
    mkdir -p $out/bin
    cp -vr ./goreleaser $out/bin/goreleaser
    installManPage ./manpages/goreleaser.1.gz
    installShellCompletion ./completions/*
  '';

  system = system;

  meta = {
    description = "Deliver Go binaries as fast and easily as possible";
    homepage = "https://goreleaser.com";
    license = lib.licenses.mit;

    platforms = [
      "aarch64-darwin"
      "aarch64-linux"
      "armv7l-linux"
      "i686-linux"
      "x86_64-darwin"
      "x86_64-linux"
    ];
  };
}
