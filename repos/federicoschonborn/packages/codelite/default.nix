{ lib
, stdenv
, fetchFromGitHub
, cmake
, ninja
, pkg-config
, which
, gtk3
, harfbuzz
, hunspell
, libssh
, sqlite
, wxGTK32
, nix-update-script
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "codelite";
  version = "17.7.0";

  src = fetchFromGitHub {
    owner = "eranif";
    repo = "codelite";
    rev = finalAttrs.version;
    hash = "sha256-kSiyB51YVFF2Ldbaiyqm/cEbeMZ9NFG/1Zbb6/PLxm8=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [
    cmake
    ninja
    pkg-config
    which
  ];

  buildInputs = [
    gtk3
    harfbuzz
    hunspell
    libssh
    sqlite
    wxGTK32
  ];

  postPatch = ''
    substituteInPlace ctags/CMakeLists.txt --replace 'ENABLE_STATIC "Enable static build" ON' 'ENABLE_STATIC "Enable static build" OFF'
    grep ENABLE_STATIC ctags/CMakeLists.txt
  '';

  env.NIX_CFLAGS_COMPILE = "-I${harfbuzz.dev}/include/harfbuzz";

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "A multi purpose IDE specialized in C/C++/Rust/Python/PHP and Node.js. Written in C";
    homepage = "https://github.com/eranif/codelite";
    license = lib.licenses.gpl2Only;
    maintainers = with lib.maintainers; [ federicoschonborn ];
    # FAILED: bin/codelite-ctags
    # ld: cannot find -lc: No such file or directory
    broken = true;
  };
})
