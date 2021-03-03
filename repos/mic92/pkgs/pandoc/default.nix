{ stdenv, lib, fetchurl }:

stdenv.mkDerivation rec {
  pname = "pandoc-bin";
  version = "2.11.4";

  src = fetchurl {
    url = "https://github.com/jgm/pandoc/releases/download/${version}/pandoc-${version}-linux-amd64.tar.gz";
    sha256 = "sha256-sVzmAJq4M/tR/Ecr+LuWg80r1/islI893ra4+aNm1po=";
  };

  installPhase = ''
    mkdir $out
    cp -r * $out
  '';

  installCheckPhase = ''
    $out/bin/pandoc --version
  '';

  dontStrip = true;

  meta = with lib; {
    description = "Universal markup converter (static binary to save disk space)";
    homepage = "https://github.com/jgm/pandoc";
    license = lib.licenses.gpl2;
    platforms = lib.platforms.unix;
  };
}
