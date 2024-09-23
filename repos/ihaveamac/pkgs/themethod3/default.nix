{ lib, rustPlatform, fetchFromGitHub }:

rustPlatform.buildRustPackage rec {
  pname = "themethod3";
  version = "2024-04-20";

  src = fetchFromGitHub {
    owner = "DarkRTA";
    repo = pname;
    rev = "4609b3c0944576faea96413199f48afa67307354";
    sha256 = "sha256-pS0m5Z/GPiXZjHPLjDUJQ6aRMaogTWR8eYpib5OelKM=";
  };

  cargoPatches = [
    ./add-Cargo.lock.patch
  ];

  cargoHash = "sha256-ehDBjBZqyVwOBv1QBe2y+2xt1fvq46mRy7io+zuzHP4=";

  meta = with lib; {
    description = "Tool for decrypting all mogg files used by the Rock Band series";
    homepage = "https://github.com/DarkRTA/themethod3";
    license = licenses.gpl3;
    platforms = platforms.all;
    mainProgram = "themethod3";
  };
}
