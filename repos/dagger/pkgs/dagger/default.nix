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
    x86_64-linux = "1lyfak8vdhdi3inc48jax8gsjpfn0bsp949li0130cm6m2djxvqm";
    armv7l-linux = "09va8hi9ixxi5ja4mpq7wh80p8sa500bg6kw3rbgnjsd7b3ls8sr";
    aarch64-linux = "1vfkmgigy0h2fbb0f56s7ph35mk73lcxybppyxryf1z9vjc88q9b";
    x86_64-darwin = "0xkirizjjjpi00br7rj8qa4wwq1i4bnw3yikh8kmg5f8bjl54yqn";
    aarch64-darwin = "1zr3rkgbrf6m67v13q571q0bs1k949c7bp3mdr38jmyd4ghy2vgf";
  };

  urlMap = {
    x86_64-linux = "https://dl.dagger.io/dagger/releases/0.10.3/dagger_v0.10.3_linux_amd64.tar.gz";
    armv7l-linux = "https://dl.dagger.io/dagger/releases/0.10.3/dagger_v0.10.3_linux_armv7.tar.gz";
    aarch64-linux = "https://dl.dagger.io/dagger/releases/0.10.3/dagger_v0.10.3_linux_arm64.tar.gz";
    x86_64-darwin = "https://dl.dagger.io/dagger/releases/0.10.3/dagger_v0.10.3_darwin_amd64.tar.gz";
    aarch64-darwin = "https://dl.dagger.io/dagger/releases/0.10.3/dagger_v0.10.3_darwin_arm64.tar.gz";
  };
in
pkgs.stdenv.mkDerivation {
  pname = "dagger";
  version = "0.10.3";
  src = fetchurl {
    url = urlMap.${system};
    sha256 = shaMap.${system};
  };

  sourceRoot = ".";

  nativeBuildInputs = [ installShellFiles ];

  installPhase = ''
    mkdir -p $out/bin
    cp -vr ./dagger $out/bin/dagger
  '';
  postInstall = ''
    installShellCompletion --cmd dagger \
    --bash <($out/bin/dagger completion bash) \
    --fish <($out/bin/dagger completion fish) \
    --zsh <($out/bin/dagger completion zsh)
  '';

  system = system;

  meta = {
    description = "Dagger is an integrated platform to orchestrate the delivery of applications";
    homepage = "https://dagger.io";
    license = lib.licenses.asl20;

    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];

    platforms = [
      "aarch64-darwin"
      "aarch64-linux"
      "armv7l-linux"
      "x86_64-darwin"
      "x86_64-linux"
    ];
  };
}
