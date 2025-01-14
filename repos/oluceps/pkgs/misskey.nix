{
  stdenv,
  lib,
  nixosTests,
  fetchFromGitHub,
  nodejs,
  pnpm,
  makeWrapper,
  python3,
  bash,
  jemalloc,
  ffmpeg-headless,
  writeShellScript,
  ...
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "misskey";

  version = "2024.9.0-alpha";

  src = fetchFromGitHub {
    owner = "misskey-dev";
    repo = finalAttrs.pname;
    rev = "d3f1b0f0909483f724c6a72ac33c2febaa330e7c";
    hash = "sha256-qjgOa+HAh3z2T36FTLcH3Pc2KHJ50bigBsTum8wJ4pA=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [
    nodejs
    pnpm.configHook
    makeWrapper
    python3
  ];

  # https://nixos.org/manual/nixpkgs/unstable/#javascript-pnpm
  pnpmDeps = pnpm.fetchDeps {
    inherit (finalAttrs) pname version src;
    hash = "sha256-ToCkQgeJcQt3+g0aluQJBTEP0XnlxkoNz4DYkBhAqZs=";
  };

  buildPhase = ''
    runHook preBuild

    # https://github.com/NixOS/nixpkgs/pull/296697/files#r1617546739
    (
      cd node_modules/.pnpm/node_modules/v-code-diff
      pnpm run postinstall
    )

    # https://github.com/NixOS/nixpkgs/pull/296697/files#r1617595593
    export npm_config_nodedir=${nodejs}
    (
      cd node_modules/.pnpm/node_modules/re2
      pnpm run rebuild
    )
    (
      cd node_modules/.pnpm/node_modules/sharp
      pnpm run install
    )

    pnpm build

    runHook postBuild
  '';

  installPhase =
    let
      checkEnvVarScript = writeShellScript "misskey-check-env-var" ''
        if [[ -z $MISSKEY_CONFIG_YML ]]; then
          echo "MISSKEY_CONFIG_YML must be set to the location of the Misskey config file."
          exit 1
        fi
      '';
    in
    ''
      runHook preInstall

      mkdir -p $out/data
      cp -r . $out/data

      # Set up symlink for use at runtime
      # TODO: Find a better solution for this (potentially patch Misskey to make this configurable?)
      # Line that would need to be patched: https://github.com/misskey-dev/misskey/blob/9849aab40283cbde2184e74d4795aec8ef8ccba3/packages/backend/src/core/InternalStorageService.ts#L18
      # Otherwise, maybe somehow bindmount a writable directory into <package>/data/files.
      ln -s /var/lib/misskey $out/data/files

      makeWrapper ${pnpm}/bin/pnpm $out/bin/misskey \
        --run "${checkEnvVarScript} || exit" \
        --chdir $out/data \
        --add-flags run \
        --set-default NODE_ENV production \
        --prefix PATH : ${
          lib.makeBinPath [
            nodejs
            pnpm
            bash
          ]
        } \
        --prefix LD_LIBRARY_PATH : ${
          lib.makeLibraryPath [
            jemalloc
            ffmpeg-headless
            stdenv.cc.cc.lib
          ]
        }

      runHook postInstall
    '';

  passthru = {
    inherit (finalAttrs) pnpmDeps;
    tests.misskey = nixosTests.misskey;
  };

  meta = {
    description = "🌎 An interplanetary microblogging platform 🚀";
    homepage = "https://misskey-hub.net/";
    license = lib.licenses.agpl3Only;
    maintainers = [ lib.maintainers.feathecutie ];
    platforms = lib.platforms.unix;
    mainProgram = "misskey";
  };
})
