{ fetchCrate
, lib
, nix-update-script
, rustPlatform
, writeText
}:

let
  rules = writeText "ch57x-udev-rules" ''
    ATTRS{idVendor}=="1189", ATTRS{idProduct}=="8890", MODE="0660", TAG+="uaccess"
  '';
in
rustPlatform.buildRustPackage rec {
  pname = "ch57x-keyboard-tool";
  version = "1.4.0";

  src = fetchCrate {
    inherit pname version;
    sha256 = "sha256-Yx+g/gNJaZFcppqo+n9+MInQCXv55UIGXw/ZmJLi+Lk=";
  };
  cargoHash = "sha256-B25mUouxgZDEcAKOlsJO9Tretuqps1+3Yy1fMDgvV00=";

  postInstall = ''
    install -D ${rules} $out/etc/udev/rules.d/70-ch57x.rules
  '';

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Command-line tool for programming ch57x keyboard";
    homepage = "https://github.com/kriomant/ch57x-keyboard-tool";
    license = lib.licenses.mit;
  };
}