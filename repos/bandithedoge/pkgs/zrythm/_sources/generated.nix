# This file was generated by nvfetcher, please do not modify it manually.
{
  fetchgit,
  fetchurl,
  fetchFromGitHub,
  dockerTools,
}: {
  carla-git = {
    pname = "carla-git";
    version = "84e2e0a4beee64297e3e33c9cb58448cb2fdbd73";
    src = fetchFromGitHub {
      owner = "falkTX";
      repo = "Carla";
      rev = "84e2e0a4beee64297e3e33c9cb58448cb2fdbd73";
      fetchSubmodules = false;
      sha256 = "sha256-AV+dceeqkCQdteHf9n37fltubKx7HsplePvHkk1ZIiE=";
    };
    date = "2024-01-05";
  };
  gtk-4_13_0 = {
    pname = "gtk-4_13_0";
    version = "4.13.0";
    src = fetchFromGitHub {
      owner = "GNOME";
      repo = "gtk";
      rev = "4.13.0";
      fetchSubmodules = false;
      sha256 = "sha256-SiL+/wfpeIUF2sQpGN1nWVn/mna+m3UxfORAFq/8fl0=";
    };
  };
  rtaudio-git = {
    pname = "rtaudio-git";
    version = "6.0.1";
    src = fetchFromGitHub {
      owner = "thestk";
      repo = "rtaudio";
      rev = "6.0.1";
      fetchSubmodules = false;
      sha256 = "sha256-Acsxbnl+V+Y4mKC1gD11n0m03E96HMK+oEY/YV7rlIY=";
    };
  };
  zrythm = {
    pname = "zrythm";
    version = "3371d14974025c4e547757a972348a1e19e5d6e8";
    src = fetchgit {
      url = "https://gitlab.zrythm.org/zrythm/zrythm.git";
      rev = "3371d14974025c4e547757a972348a1e19e5d6e8";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-QJeN88weAFS+vub2fqdrBwQIQ+dXhpEudjRmlJ/0lgo=";
    };
    date = "2024-01-26";
  };
}
