{ stdenv
, lib
, python3Packages
, fetchFromGitHub
, substituteAll
, lzip
, util-linux
, nix-update-script
}:
let
  pname = "waydroid-script";
  version = "unstable-2024-01-03";
  src = fetchFromGitHub {
    repo = "waydroid_script";
    owner = "casualsnek";
    rev = "97293f3cc16420092096317e2d9ecbdbc3456428";
    hash = "sha256-EmgS8frKKsOtE1UjKvebnV1822R95IrsfxZFSsdTk28=";
  };

  resetprop = stdenv.mkDerivation {
    pname = "resetprop";
    inherit version src;
    dontBuild = true;
    installPhase = ''
      mkdir -p $out/share
      cp -r bin/* $out/share/
    '';
  };
in python3Packages.buildPythonApplication rec {
  inherit pname version src;

  propagatedBuildInputs = with python3Packages; [
    inquirerpy
    requests
    tqdm

    lzip
    util-linux
  ];

  postPatch = let
    setup = substituteAll {
      src = ./setup.py;
      inherit pname;
      desc = meta.description;
      version = builtins.replaceStrings [ "-" ] [ "." ]
        (lib.strings.removePrefix "unstable-" version);
    };
  in ''
    ln -s ${setup} setup.py

    substituteInPlace stuff/general.py \
      --replace "os.path.dirname(__file__), \"..\", \"bin\"," "\"${resetprop}/share\","
  '';

  passthru.updateScript = nix-update-script {
    extraArgs = [ "--version=branch" ];
  };

  meta = with lib; {
    description = "Python Script to add libraries to waydroid";
    homepage = "https://github.com/casualsnek/waydroid_script";
    license = licenses.gpl3;
    platforms = platforms.linux;
    maintainers = with maintainers; [ ataraxiasjel ];
  };
}
