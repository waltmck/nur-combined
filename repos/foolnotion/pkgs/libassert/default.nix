{ lib, stdenv, fetchFromGitHub, cmake, cpptrace, magic-enum, zstd, libdwarf }:
stdenv.mkDerivation rec {
  pname = "libassert";
  version = "2.0.1";

  src = fetchFromGitHub {
    owner = "jeremy-rifkin";
    repo = "libassert";
    rev = "v${version}";
    hash = "sha256-YJdyq3+H5VmuFbL12aQrdnHLJWEL8XP/o9KJtMBjxOI=";
  };

  nativeBuildInputs = [ cmake ];

  buildInputs = [ cpptrace magic-enum zstd libdwarf ];

  cmakeFlags = [
    "-DLIBASSERT_USE_EXTERNAL_CPPTRACE=1"
    "-DLIBASSERT_USE_EXTERNAL_MAGIC_ENUM=1"
  ] ++ cpptrace.cmakeFlags;

  meta = with lib; {
    description = "Generic header-only C++14 sorting library.";
    homepage = "https://github.com/Morwenn/cpp-sort";
    license = licenses.mit;
    platforms = platforms.all;
    #maintainers = with maintainers; [ foolnotion ];
  };
}
