{ lib
, rustPlatform
, fetchFromGitHub
, pkg-config
, sqlite
, zstd
}:

rustPlatform.buildRustPackage {
  pname = "moss";
  version = "unstable-2023-10-09";

  src = fetchFromGitHub {
    owner = "serpent-os";
    repo = "moss-rs";
    rev = "997985fccb433682f008bb710d9fffb8c4b893cf";
    hash = "sha256-1gd7UfJ5dQlpWiOB041Oa4M/VyBoRzeNQNaKUgOaXjc=";
  };

  cargoHash = "sha256-ohNoh6Crx2Q2GyxTSrnwxX5I44LntiKddaFBj1eMBBA=";

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    sqlite
    zstd
  ];

  env.ZSTD_SYS_USE_PKG_CONFIG = true;

  meta = with lib; {
    description = "The safe, fast and sane package manager for Linux";
    homepage = "https://github.com/serpent-os/moss-rs";
    platforms = platforms.linux;
    license = licenses.mpl20;
    maintainers = with maintainers; [ federicoschonborn ];
  };
}
