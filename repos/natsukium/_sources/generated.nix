# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  copyq-darwin = {
    pname = "copyq-darwin";
    version = "9.0.0";
    src = fetchurl {
      url = "https://github.com/hluk/CopyQ/releases/download/v9.0.0/CopyQ-macos-12-m1.dmg.zip";
      sha256 = "sha256-ABLYjG2OW6wpMI7uXudkM8MYEQBRbxbGcBm2iiuN/0w=";
    };
  };
  emacs-plus = {
    pname = "emacs-plus";
    version = "c814e799b4d3491eb375d01af6cfba4fb8cca2a6";
    src = fetchFromGitHub {
      owner = "d12frosted";
      repo = "homebrew-emacs-plus";
      rev = "c814e799b4d3491eb375d01af6cfba4fb8cca2a6";
      fetchSubmodules = false;
      sha256 = "sha256-7SUwEeJvNc9/F1kaKPQviKC0VzISekkTW/MvmgMyuqM=";
    };
    date = "2024-09-12";
  };
  nixpkgs-review = {
    pname = "nixpkgs-review";
    version = "8e8f6f97a8259728f7bdbe8ca0aaec87d5f33cc9";
    src = fetchFromGitHub {
      owner = "natsukium";
      repo = "nixpkgs-review";
      rev = "8e8f6f97a8259728f7bdbe8ca0aaec87d5f33cc9";
      fetchSubmodules = false;
      sha256 = "sha256-E8dtlnor79fKVGAGxwibntfSPCcjCmpAYLO+Dxku69k=";
    };
    date = "2024-02-20";
  };
  qmk-toolbox = {
    pname = "qmk-toolbox";
    version = "0.3.3";
    src = fetchurl {
      url = "https://github.com/qmk/qmk_toolbox/releases/download/0.3.3/QMK.Toolbox.app.zip";
      sha256 = "sha256-WPre2csGAQzavtksLbj3L/MrWUT6d2gTJVq7eAmpcLk=";
    };
  };
  qutebrowser-darwin = {
    pname = "qutebrowser-darwin";
    version = "3.2.1";
    src = fetchurl {
      url = "https://github.com/qutebrowser/qutebrowser/releases/download/v3.2.1/qutebrowser-3.2.1-arm64.dmg";
      sha256 = "sha256-HNEXLXy1rgHiD97JyOEuBuZAeGjge1wvHgo9esZZKCY=";
    };
  };
  sbarlua = {
    pname = "sbarlua";
    version = "29395b1928835efa1b376d438216fbf39e0d0f83";
    src = fetchFromGitHub {
      owner = "FelixKratz";
      repo = "SbarLua";
      rev = "29395b1928835efa1b376d438216fbf39e0d0f83";
      fetchSubmodules = false;
      sha256 = "sha256-C2tg1mypz/CdUmRJ4vloPckYfZrwHxc4v8hsEow4RZs=";
    };
    date = "2024-02-28";
  };
  skkeleton = {
    pname = "skkeleton";
    version = "039aebf7c2b7ed76989696dbd477e220731e19f9";
    src = fetchFromGitHub {
      owner = "vim-skk";
      repo = "skkeleton";
      rev = "039aebf7c2b7ed76989696dbd477e220731e19f9";
      fetchSubmodules = false;
      sha256 = "sha256-nvwnyFTiGyVseyGfp92szbh4Ca+EgJ3otbMk8xFVCBY=";
    };
    date = "2024-09-16";
  };
  vivaldi-darwin = {
    pname = "vivaldi-darwin";
    version = "6.9.3447.44";
    src = fetchurl {
      url = "https://downloads.vivaldi.com/stable/Vivaldi.6.9.3447.44.universal.dmg";
      sha256 = "sha256-j7kxMk1c/BAgEdb9nTYt+ltQIcigm8jvTaNJiw8Gmeg=";
    };
  };
}
