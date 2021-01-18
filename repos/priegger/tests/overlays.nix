import ./lib/make-test.nix (
  { pkgs, ... }: {
    name = "overlays";
    nodes =
      let
        priegger-overlays = import ../overlays;
      in
      {
        default = { pkgs, ... }: {
          nixpkgs.overlays = builtins.attrValues priegger-overlays;

          environment.systemPackages = with pkgs; [
            brlaser
            cadvisor
            factorio-headless-experimental
            prometheus-nginx-exporter
          ];
        };
      };

    testScript =
      ''
        default.succeed("cadvisor --version 2>&1 | tee /dev/stderr | grep '0.37.0'")
        default.succeed(
            "factorio --version 2>&1 | tee /dev/stderr | grep 'Version: 1.1.12 (build 57713, linux64, headless)'"
        )
        default.succeed(
            "(nginx-prometheus-exporter || true) 2>&1 | head -n1 | tee /dev/stderr | grep ' Version=0.8.0 '"
        )
      '';
  }
)
