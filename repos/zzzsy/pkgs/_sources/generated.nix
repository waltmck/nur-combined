# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  firefox-gnome-theme = {
    pname = "firefox-gnome-theme";
    version = "fb5b578a4f49ae8705e5fea0419242ed1b8dba70";
    src = fetchFromGitHub {
      owner = "rafaelmardojai";
      repo = "firefox-gnome-theme";
      rev = "fb5b578a4f49ae8705e5fea0419242ed1b8dba70";
      fetchSubmodules = false;
      sha256 = "sha256-MOE9NeU2i6Ws1GhGmppMnjOHkNLl2MQMJmGhaMzdoJM=";
    };
    date = "2024-08-08";
  };
  iosevka-zt = {
    pname = "iosevka-zt";
    version = "31.2.0";
    src = fetchurl {
      url = "https://github.com/zzzsyyy/Iosevka/releases/download/v31.2.0/Iosevka-31.2.0.txz";
      sha256 = "sha256-9rL+gEuWqIYlTJ8GA6ylVEgDYj02HfQ08Jic8WWmhYA=";
    };
  };
  librime-lua = {
    pname = "librime-lua";
    version = "fa6563cf7b40f3bfbf09e856420bff8de6820558";
    src = fetchFromGitHub {
      owner = "hchunhui";
      repo = "librime-lua";
      rev = "fa6563cf7b40f3bfbf09e856420bff8de6820558";
      fetchSubmodules = false;
      sha256 = "sha256-jv5TZSp36UGbaRiXv9iUNLu3DE/yrWANQhY6TWLPD8c=";
    };
    date = "2024-08-19";
  };
  lxgw-wenkai-screen = {
    pname = "lxgw-wenkai-screen";
    version = "v1.330";
    src = fetchurl {
      url = "https://github.com/lxgw/LxgwWenKai-Screen/releases/download/v1.330/LXGWWenKaiScreen.ttf";
      sha256 = "sha256-3C6gZmL5Bn6+26TfI2UdCCnGI8Vw4UTFJRc8n6qlP5o=";
    };
  };
  plangothic = {
    pname = "plangothic";
    version = "V1.8.5764";
    src = fetchFromGitHub {
      owner = "Fitzgerald-Porthmouth-Koenigsegg";
      repo = "Plangothic-Project";
      rev = "V1.8.5764";
      fetchSubmodules = false;
      sha256 = "sha256-+vKUWaqBwM4WUon9pEC5Fg/HngKQuhTkWXDF8g9ov1w=";
    };
  };
  rime-ice = {
    pname = "rime-ice";
    version = "2ea99c5e4f3afaa24ebef61d17ea097557ca36b3";
    src = fetchFromGitHub {
      owner = "iDvel";
      repo = "rime-ice";
      rev = "2ea99c5e4f3afaa24ebef61d17ea097557ca36b3";
      fetchSubmodules = false;
      sha256 = "sha256-6leug6CxZjg855fjW2mKPLcmMTO/KE9xjLm9hbZH2Fo=";
    };
    date = "2024-09-16";
  };
}
