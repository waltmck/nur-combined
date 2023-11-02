{ buildGoModule, lib, installShellFiles, fetchFromGitHub }:
let
  short_hash = "62defae";
in buildGoModule rec {
  pname = "deck";
  version = "1.28.1";

  src = fetchFromGitHub {
    owner = "Kong";
    repo = "deck";
    rev = "v${version}";
    sha256 = "1x5ns1il2ipwyrawvhdzxxh130f6wz481clvn2dfzq571m7xahdi";
  };

  nativeBuildInputs = [ installShellFiles ];

  CGO_ENABLED = 0;

  ldflags = [
    "-s -w -X github.com/kong/deck/cmd.VERSION=${version}"
    "-X github.com/kong/deck/cmd.COMMIT=${short_hash}"
  ];

  vendorHash = "sha256-kVc0ElVGyyei5PMfZN+GPHeQYfSmmPRAFrW21MTi8Mk=";

  passthru.updateScript = ./update.sh;

  postInstall = ''
    installShellCompletion --cmd deck \
      --bash <($out/bin/deck completion bash) \
      --fish <($out/bin/deck completion fish) \
      --zsh <($out/bin/deck completion zsh)
  '';

  meta = with lib; {
    description = "A configuration management and drift detection tool for Kong";
    homepage = "https://github.com/Kong/deck";
    license = licenses.asl20;
    maintainers = with maintainers; [ liyangau ];
  };
}