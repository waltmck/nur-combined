{ lib, stdenv, python3, wsgiserver, fetchFromGitHub, ffmpeg, libaom, libvpx, dav1d, setuptools, makeWrapper }:

let
  pythonEnv = python3.withPackages (pythonPackages: with pythonPackages; [
    flask
    flask-cors
    wsgiserver
    enzyme
    requests
    setuptools
  ]);
in
stdenv.mkDerivation { 
  pname = "grav1";
  version = "0.0.0-20200708";

  src = fetchFromGitHub {
    owner = "wwww-wwww";
    repo = "grav1";
    rev = "975e16d7fedc2d4f012c694cb5b1b0876c3cac01";
    sha256 = "11vingnczwy7wxrzp0hqij0jwwzbwjjd8l35wk2zps28npazaly3";
  };

#  src = ./grav1;

  nativeBuildInputs = [ makeWrapper ];
  buildInputs = [ pythonEnv ];

  installPhase = ''
    mkdir -p $out/bin
    cp server.py $out/bin/server
    cp logger.py $out/bin/logger.py
    cp project.py $out/bin/project.py
    cp split.py $out/bin/split.py
    cp util.py $out/bin/util.py
    cp mkv_keyframes.py $out/bin/mkv_keyframes.py
    cp aom_keyframes.py $out/bin/aom_keyframes.py
    cp actions.py $out/bin/actions.py
    chmod +x $out/bin/server

    cp grav1c.py $out/bin/client
    chmod +x $out/bin/client

    wrapProgram $out/bin/server \
      --prefix PATH : ${lib.makeBinPath [ ffmpeg libaom libvpx (dav1d.override { withTools = true;}) ]}

    wrapProgram $out/bin/client \
      --prefix PATH : ${lib.makeBinPath [ ffmpeg libaom libvpx (dav1d.override { withTools = true;}) ]}
  '';

}
