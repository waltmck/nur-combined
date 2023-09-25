{ lib
, fetchFromGitHub
, python3Packages
}:

python3Packages.buildPythonPackage rec {
  pname = "tbc-video-export";
  version = "0.0.10";

  src = fetchFromGitHub {
    owner = "JuniorIsAJitterbug";
    repo = "tbc-video-export";
    rev = "v${version}";
    sha256 = "sha256-mnINILhUgKmGqeVErO3xupIcQz+CSoW8jq2BArWBHOI=";
  };

  dontBuild = true;
  format = "other";

  installPhase = ''
    install -Dm755 tbc-video-export.py $out/bin/tbc-video-export
    install -Dm755 tbc-video-export.json $out/bin/tbc-video-export.json
  '';

  meta = with lib; {
    description = "Script for exporting TBC files to video.";
    homepage = "https://github.com/JuniorIsAJitterbug/tbc-video-export";
    license = licenses.gpl3;
    maintainers = [ "JuniorIsAJitterbug" ];
    platforms = platforms.all;
  };
}
