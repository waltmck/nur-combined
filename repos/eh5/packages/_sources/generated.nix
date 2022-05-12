# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub }:
{
  geoip-dat = {
    pname = "geoip-dat";
    version = "202205120444";
    src = fetchurl {
      url = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202205120444/geoip.dat";
      sha256 = "sha256-Y6SQ+mEg5v/M7HtJJevAn+Fl3ML0e9PztsClmPvmLIQ=";
    };
  };
  geosite-dat = {
    pname = "geosite-dat";
    version = "202205120444";
    src = fetchurl {
      url = "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/download/202205120444/geosite.dat";
      sha256 = "sha256-rMLSMF45ClZ38LVNF4woBYBoUL1++k5VMGh5lWoq5A8=";
    };
  };
  mosdns = {
    pname = "mosdns";
    version = "v3.8.0";
    src = fetchFromGitHub ({
      owner = "IrineSistiana";
      repo = "mosdns";
      rev = "v3.8.0";
      fetchSubmodules = false;
      sha256 = "sha256-On1TTyaNmodePmQ56Gt0SG+w2I5XR4Ze5dUl7H8R+TI=";
    });
  };
  v2ray = {
    pname = "v2ray";
    version = "v5.0.6";
    src = fetchFromGitHub ({
      owner = "v2fly";
      repo = "v2ray-core";
      rev = "v5.0.6";
      fetchSubmodules = false;
      sha256 = "sha256-eseNLX9V12ZhMUEXPVP9XhvZHlJlsOqhaNY5/HS3bKs=";
    });
  };
}
