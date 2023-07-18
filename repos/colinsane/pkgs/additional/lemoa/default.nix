{ lib
, fetchFromGitHub
, gdk-pixbuf
, glib
, graphene
, gtk4
, libadwaita
, openssl
, pango
, pkg-config
, rustPlatform
}:

rustPlatform.buildRustPackage rec {
  pname = "lemoa";
  version = "0.3.0";

  src = fetchFromGitHub {
    owner = "lemmy-gtk";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-LT+UkjDkKbi327SE4VT+BdrpE6hQywajIZ7xpJPvvCc=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
  };

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [
    gtk4
    libadwaita
    openssl
  ];

  meta = with lib; {
    description = "Native Gtk client for Lemmy";
    homepage = "https://github.com/lemmy-gtk/lemoa";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ colinsane ];
  };
}
