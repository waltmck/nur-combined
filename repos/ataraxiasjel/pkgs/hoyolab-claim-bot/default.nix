{
  lib,
  rustPlatform,
  fetchFromGitHub,
  openssl,
  pkg-config,
  nix-update-script,
}:
rustPlatform.buildRustPackage rec {
  pname = "hoyolab-claim-bot";
  version = "1.0.1";

  src = fetchFromGitHub {
    owner = "AtaraxiaSjel";
    repo = "hoyolab-claim-bot";
    rev = "v${version}";
    hash = "sha256-Cgv6qstlxUjygylD4Ii4r8OBjQ50i/ysd2yE0fKunL8=";
  };

  cargoHash = "sha256-xZ4DblznnTMhDKd5sELe9JMLn2bJClrwjLcXzvT6oOA=";

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ openssl ];

  passthru.updateScript = nix-update-script { };

  meta = with lib; {
    description = "Hoyolab daily claim bot for Hoyoverse games";
    homepage = "https://github.com/AtaraxiaSjel/hoyolab-claim-bot";
    license = licenses.mit;
    maintainers = with maintainers; [ ataraxiasjel ];
    platforms = [
      "x86_64-linux"
      "aarch64-linux"
      "aarch64-darwin"
    ];
  };
}
