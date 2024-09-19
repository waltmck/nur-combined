# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  alist = {
    pname = "alist";
    version = "v3.37.4";
    src = fetchFromGitHub {
      owner = "alist-org";
      repo = "alist";
      rev = "v3.37.4";
      fetchSubmodules = false;
      sha256 = "sha256-xNkcekxb0Aw7trBPxc0/Akb0ntx4DKM9b+i5SQju2lw=";
    };
  };
  cyrus-imapd = {
    pname = "cyrus-imapd";
    version = "cyrus-imapd-3.10.0";
    src = fetchFromGitHub {
      owner = "cyrusimap";
      repo = "cyrus-imapd";
      rev = "cyrus-imapd-3.10.0";
      fetchSubmodules = false;
      sha256 = "sha256-dyybRqmrVX+ERGpToS5JjGC6S/B0t967dLCWfeUrLKA=";
    };
  };
}
