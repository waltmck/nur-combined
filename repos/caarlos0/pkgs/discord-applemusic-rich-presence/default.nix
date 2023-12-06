{ buildGoModule, fetchFromGitHub, lib, stdenv, ... }:
buildGoModule rec {
  pname = "discord-applemusic-rich-presence";
  version = "0.5.0";

  src = fetchFromGitHub {
    owner = "caarlos0";
    repo = "discord-applemusic-rich-presence";
    rev = "v${version}";
    sha256 = "sha256-PCA0Thzng1C08NwBTh3Hl4yW2qvYXra6EZHrJxoCgIU=";
  };

  vendorHash = "sha256-RFJTBfsfEyKn9OSvE2HLgjKiJC3Hs90+P9rm5GlIseo=";

  ldflags =
    [ "-s" "-w" "-X=main.version=${version}" "-X=main.builtBy=nixpkgs" ];

  meta = with lib; {
    description = "Discord's Rich Presence from Apple Music";
    homepage = "https://github.com/caarlos0/discord-applemusic-rich-presence";
    license = licenses.mit;
    platforms = platforms.darwin;
    broken = stdenv.isLinux;
  };
}
