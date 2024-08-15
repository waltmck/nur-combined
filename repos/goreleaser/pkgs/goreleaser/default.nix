# This file was generated by GoReleaser. DO NOT EDIT.
# vim: set ft=nix ts=2 sw=2 sts=2 et sta
{
system ? builtins.currentSystem
, lib
, fetchurl
, installShellFiles
, stdenvNoCC
}:
let
  shaMap = {
    i686-linux = "16yhs7sffyjnkq42l3jf1rzr65hfbxv597w3g32i1h756p22b2bv";
    x86_64-linux = "12m9km4lavhkrd1p7wcjkrwfqsjzwxg022sv0hlrynanlngr1y0v";
    armv7l-linux = "0pj4a40gsd0xwa0xsdps994rcc234gz7cn3bcyickzjpfnnq1nv4";
    aarch64-linux = "1sfx6naqy9g4l112jkjdhp0ick3vab3n4b2vrfi3cvr3r7cp79fr";
    x86_64-darwin = "0hapfc42z5sm7ksdk9dylxwbpvy34c2nd8vy8yalnkr1azvb85jk";
    aarch64-darwin = "10p5b65rlnc4lpc0kndsib9fcya9iy4mxd29b61zfi2nijwdshjv";
  };

  urlMap = {
    i686-linux = "https://github.com/goreleaser/goreleaser/releases/download/v2.2.0/goreleaser_Linux_i386.tar.gz";
    x86_64-linux = "https://github.com/goreleaser/goreleaser/releases/download/v2.2.0/goreleaser_Linux_x86_64.tar.gz";
    armv7l-linux = "https://github.com/goreleaser/goreleaser/releases/download/v2.2.0/goreleaser_Linux_armv7.tar.gz";
    aarch64-linux = "https://github.com/goreleaser/goreleaser/releases/download/v2.2.0/goreleaser_Linux_arm64.tar.gz";
    x86_64-darwin = "https://github.com/goreleaser/goreleaser/releases/download/v2.2.0/goreleaser_Darwin_x86_64.tar.gz";
    aarch64-darwin = "https://github.com/goreleaser/goreleaser/releases/download/v2.2.0/goreleaser_Darwin_arm64.tar.gz";
  };
in
stdenvNoCC.mkDerivation {
  pname = "goreleaser";
  version = "2.2.0";
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

    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];

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
