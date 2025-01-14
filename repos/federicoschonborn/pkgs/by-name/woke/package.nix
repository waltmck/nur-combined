{
  lib,
  buildGoModule,
  fetchFromGitHub,
  nix-update-script,
}:

let
  version = "0.19.0";
in

buildGoModule {
  pname = "woke";
  inherit version;

  src = fetchFromGitHub {
    owner = "get-woke";
    repo = "woke";
    rev = "v${version}";
    hash = "sha256-X9fhExHhOLjPfpwrYPMqTJkgQL2ruHCGEocEoU7m6fM=";
  };

  vendorHash = "sha256-lRUvoCiE6AkYnyOCzev1o93OhXjJjBwEpT94JTbIeE8=";

  ldflags = [
    "-s"
    "-w"
  ];

  doCheck = false;

  passthru.updateScript = nix-update-script { };

  meta = {
    mainProgram = "woke";
    description = "Detect non-inclusive language in your source code";
    homepage = "https://github.com/get-woke/woke";
    license = lib.licenses.mit;
    platforms = lib.platforms.unix;
    maintainers = with lib.maintainers; [ federicoschonborn ];
  };
}
