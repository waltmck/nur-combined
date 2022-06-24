# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub }:
{
  geoip-dat = {
    pname = "geoip-dat";
    version = "202206232211";
    src = fetchurl {
      url = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202206232211/geoip.dat";
      sha256 = "sha256-5T9SQ+Q8icszns1lVZfolKJK1MUCvZrZnrHe5GWU6mc=";
    };
  };
  geosite-dat = {
    pname = "geosite-dat";
    version = "202206232211";
    src = fetchurl {
      url = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202206232211/geosite.dat";
      sha256 = "sha256-h004ebva0Mvy2frUVxhqCaY9LlGpWliTGUA0epFxN1Q=";
    };
  };
  mosdns = {
    pname = "mosdns";
    version = "v3.9.0";
    src = fetchFromGitHub ({
      owner = "IrineSistiana";
      repo = "mosdns";
      rev = "v3.9.0";
      fetchSubmodules = false;
      sha256 = "sha256-VavBpBDjesBMhrNQipxBSBeGy1mr2F2WAvxGr+83i+o=";
    });
  };
  v2ray = {
    pname = "v2ray";
    version = "v5.0.7";
    src = fetchFromGitHub ({
      owner = "v2fly";
      repo = "v2ray-core";
      rev = "v5.0.7";
      fetchSubmodules = false;
      sha256 = "sha256-jFrjtAPym3LJcsudluJNOihQJtuVcnIvJris+kmBDgo=";
    });
  };
}
