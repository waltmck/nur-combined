with import ./globalConfig.nix;
self: super:
let
  recursiveUpdate = super.lib.recursiveUpdate;
  cp = f: (super.callPackage f) {};
  dotenv = cp flake.inputs.dotenv;
    wrapDotenv = (file: script:
    let
      dotenvFile = ((toString rootPath) + "/secrets/" + (toString file));
      command = super.writeShellScript "dotenv-wrapper" script;
    in ''
      ${dotenv}/bin/dotenv "@${toString dotenvFile}" -- ${command} "$@"
    '');

  reduceJoin = items:
  if (builtins.length items) > 0 then
    (recursiveUpdate (builtins.head items) (reduceJoin (builtins.tail items)))
  else
  {};
in reduceJoin [
  super
  {
    lib = {
      inherit reduceJoin;
      maintainers = import "${flake.inputs.nixpkgsLatestSmall}/maintainers/maintainer-list.nix";
    };
    latest = cp flake.inputs.nixpkgsLatest;
    latest-small = cp flake.inputs.nixpkgsLatestSmall;
    p2k = cp flake.inputs.pocket2kindle;
    redial_proxy = cp flake.inputs.redial_proxy;
    send2kindle = cp flake.inputs.send2kindle;
    discord = cp "${flake.inputs.nixpkgsLatestSmall}/pkgs/applications/networking/instant-messengers/discord/default.nix";
    onlyoffice-bin = cp "${flake.inputs.nixpkgsLatestSmall}/pkgs/applications/office/onlyoffice-bin/default.nix";
    webapp = cp ./packages/webapp.nix;
    webapps = import ./packages/chromeapps.nix super;
    arcan = cp ./packages/arcan.nix;
    c4me = cp ./packages/c4me;
    cisco-packet-tracer = cp ./packages/cisco-packet-tracer.nix;
    custom_neovim = cp ./modules/neovim/package.nix;
    wineApps = {
      wine7zip = cp ./packages/wineApps/7zip.nix;
      cs_extreme = cp ./packages/wineApps/cs_extreme.nix;
      dead_space = cp ./packages/wineApps/dead_space.nix;
      gta_sa = cp ./packages/wineApps/gta_sa.nix;
      among_us = cp ./packages/wineApps/among_us.nix;
      ets2 = cp ./packages/wineApps/ets2.nix;
      mspaint = cp ./packages/wineApps/mspaint.nix;
      pinball = cp ./packages/wineApps/pinball.nix;
      sosim = cp ./packages/wineApps/sosim.nix;
      tora = cp ./packages/wineApps/tora.nix;
      nfsu2 = cp ./packages/wineApps/nfsu2.nix;
      flatout2 = cp ./packages/wineApps/flatout2.nix;
    };
    among_us = cp ./packages/among_us.nix;
    comby = cp ./packages/comby.nix;
    custom_rofi = cp ./packages/custom_rofi.nix;
    custom_ncdu = cp ./packages/custom_ncdu.nix;
    minecraft = cp ./packages/minecraft.nix;
    peazip = cp ./packages/peazip.nix;
    pkg = cp ./packages/pkg.nix;
    stremio = cp ./packages/stremio.nix;
    usb_tixati = cp ./packages/usb_tixati.nix;
    wrapWine = cp ./packages/wrapWine.nix;
    preload = cp ./packages/preload.nix;
    python3Packages = cp ./packages/python3Packages.nix;
    nodePackages = cp ./modules/node_clis/package_data/default.nix;
    inherit dotenv;
    inherit wrapDotenv;
    nur = import flake.inputs.nur {
      inherit (super) pkgs;
      nurpkgs = super.pkgs;
    };
  }
]
