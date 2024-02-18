{ stdenv
, callPackage
, fetchurl
, gnused
, jq
, lib
, newScope
, nix-update-script
, strip-nondeterminism
, unzip
, writeScript
, zip
}:
let
  wrapAddon = addon: args:
  let
    extid = addon.passthru.extid;
    # merge our requirements into the derivation args
    args' = args // {
      passthru = {
        inherit extid;
        original = addon;
      } // (args.passthru or {});
      nativeBuildInputs = [
        jq
        strip-nondeterminism
        unzip
        zip
      ] ++ (args.nativeBuildInputs or []);
    };
  in (stdenv.mkDerivation ({
    # heavily borrows from <repo:nixos/nixpkgs:pkgs/build-support/fetchfirefoxaddon/default.nix>
    name = "${addon.name}-wrapped";
    unpackPhase = ''
      echo "patching firefox addon $name into $out/${extid}.xpi"

      mkdir build
      cd build
      # extract the XPI into the build directory
      # it could be already wrapped, or a raw fetchurl result
      unzip -q "${addon}/${extid}.xpi" -d . || \
        unzip -q "${addon}" -d .
    '';

    patchPhase = ''
      runHook prePatch

      # firefox requires addons to have an id field when sideloading:
      # - <https://extensionworkshop.com/documentation/publish/distribute-sideloading/>
      NEW_MANIFEST=$(jq '. + {"applications": { "gecko": { "id": "${extid}" }}, "browser_specific_settings":{"gecko":{"id": "${extid}"}}}' manifest.json)
      echo "$NEW_MANIFEST" > manifest.json

      runHook postPatch
    '';

    installPhase = ''
      runHook preInstall

      # repackage the XPI
      mkdir "$out"
      zip -r -q -FS "$out/${extid}.xpi" ./*
      strip-nondeterminism "$out/${extid}.xpi"

      runHook postInstall
    '';
  } // args')).overrideAttrs (final: upstream: {
    passthru = (upstream.passthru or {}) // {
      withAttrs = attrs: wrapAddon addon (args // attrs);
      withPostPatch = postPatch: final.passthru.withAttrs { inherit postPatch; };
      # given an addon, repackage it without some `perm`ission
      withoutPermission = perm: final.passthru.withPostPatch ''
        NEW_MANIFEST=$(jq 'del(.permissions[] | select(. == "${perm}"))' manifest.json)
        echo "$NEW_MANIFEST" > manifest.json
      '';
    };
  });

  # fetchAddon: fetch an addon directly from the mozilla store.
  #             prefer NOT to use this, because moz store doesn't offer versioned release access
  #             which breaks caching/reproducibility and such.
  #             (maybe the `latest.xpi` URL redirects to a versioned URI visible if i used curl?)
  # fetchAddon = name: extid: hash: fetchurl {
  #   inherit name hash;
  #   url = "https://addons.mozilla.org/firefox/downloads/latest/${name}/latest.xpi";
  #   # extid can be found by unar'ing the above xpi, and copying browser_specific_settings.gecko.id field
  #   passthru = { inherit extid; };
  # };

  fetchVersionedAddon = { extid, version, url, hash ? "", pname ? extid }: stdenv.mkDerivation {
    inherit pname version;
    src = fetchurl {
      inherit url hash;
    };
    dontUnpack = true;
    installPhase = ''
      cp $src $out
    '';

    passthru.updateScript = nix-update-script {
      extraArgs = [
        # uBlock mixes X.YY.ZbN and X.YY.ZrcN style.
        # default nix-update accepts the former but rejects the later as unstable.
        # that's problematic because beta releases later get pulled.
        # ideally i'd reject both, but i don't know how.
        "--version=unstable"
      ];
    };
    passthru.extid = extid;
  };

in (lib.makeScope newScope (self: with self; {
  unwrapped = lib.recurseIntoAttrs {
    # get names from:
    # - ~/ref/nix-community/nur-combined/repos/rycee/pkgs/firefox-addons/generated-firefox-addons.nix
    # `wget ...xpi`; `unar ...xpi`; `cat */manifest.json | jq '.browser_specific_settings.gecko.id'`
    browserpass-extension = callPackage ./browserpass-extension { };
    bypass-paywalls-clean = callPackage ./bypass-paywalls-clean { };
    ctrl-shift-c-should-copy = callPackage ./ctrl-shift-c-should-copy { };
    open-in-mpv = callPackage ./open-in-mpv { };

    ether-metamask = fetchVersionedAddon rec {
      extid = "webextension@metamask.io";
      pname = "ether-metamask";
      url = "https://github.com/MetaMask/metamask-extension/releases/download/v${version}/metamask-firefox-${version}.zip";
      version = "11.10.0-mmi.0";
      hash = "sha256-X9y4EwYze6ja1cPRSEwtyDgIfeb8RJGa66Qts1X+2DM=";
    };
    fx_cast = fetchVersionedAddon rec {
      extid = "fx_cast@matt.tf";
      pname = "fx_cast";
      url = "https://github.com/hensm/fx_cast/releases/download/v${version}/fx_cast-${version}.xpi";
      version = "0.3.1";
      hash = "sha256-zaYnUJpJkRAPSCpM3S20PjMS4aeBtQGhXB2wgdlFkSQ=";
    };
    i2p-in-private-browsing = fetchVersionedAddon rec {
      extid = "i2ppb@eyedeekay.github.io";
      pname = "i2p-in-private-browsing";
      url = "https://github.com/eyedeekay/I2P-in-Private-Browsing-Mode-Firefox/releases/download/${version}/i2ppb@eyedeekay.github.io.xpi";
      version = "1.49";
      hash = "sha256-LnR5z3fqNJywlr/khFdV4qloKGQhbxNZQvWCEgz97DU=";
    };
    sidebery = fetchVersionedAddon rec {
      extid = "{3c078156-979c-498b-8990-85f7987dd929}";
      pname = "sidebery";
      # N.B.: unsure if this URL format is stable
      # 2024/02/02: nope, dev is inconsistent with releases
      url = "https://github.com/mbnuqw/sidebery/releases/download/v${version}/sidebery-${version}-unsigned.zip";
      version = "5.0.0";
      hash = "sha256-tHTU/l8ct+tY1/H+nZf3VlMlwoYn68+0pgeuFzm91XY=";
    };
    sponsorblock = fetchVersionedAddon rec {
      extid = "sponsorBlocker@ajay.app";
      pname = "sponsorblock";
      url = "https://github.com/ajayyy/SponsorBlock/releases/download/${version}/FirefoxSignedInstaller.xpi";
      version = "5.5.5";
      hash = "sha256-y4lh3t/L8ZMnY9220dDkIaUy23eYeFpO9CBtOsRrrjI=";
    };
    ublacklist = fetchVersionedAddon rec {
      extid = "@ublacklist";
      pname = "ublacklist";
      url = "https://github.com/iorate/ublacklist/releases/download/v${version}/ublacklist-v${version}-firefox.zip";
      version = "8.5.0";
      hash = "sha256-tEKRgzJQ94IxMl41XMpHVrii8vYz9ZQ/fjLKFalIwPg=";
    };
    ublock-origin = fetchVersionedAddon rec {
      extid = "uBlock0@raymondhill.net";
      pname = "ublock-origin";
      # N.B.: a handful of versions are released unsigned
      # url = "https://github.com/gorhill/uBlock/releases/download/${version}/uBlock0_${version}.signed.xpi";
      url = "https://github.com/gorhill/uBlock/releases/download/${version}/uBlock0_${version}.firefox.signed.xpi";
      version = "1.56.1b0";
      hash = "sha256-8qKK7pEXTkUHmgFXFCUzwzv6wSEvVTITpHkhODy4DT8=";
    };
  };
})).overrideScope (self: super:
  let
    wrapped = lib.mapAttrs (name: _value: wrapAddon self.unwrapped."${name}" {}) super.unwrapped;
  in wrapped // {
    browserpass-extension = wrapped.browserpass-extension.withoutPermission "notifications";
    sponsorblock = wrapped.sponsorblock.withPostPatch ''
      # patch sponsorblock to not show the help tab on first launch.
      #
      # XXX: i tried to build sponsorblock from source and patch this *before* it gets webpack'd,
      # but web shit is absolutely cursed and building from source requires a fucking PhD
      # (if you have one, feel free to share your nix package)
      #
      # NB: in source this is `alreadyInstalled: false`, but the build process hates Booleans or something
      substituteInPlace js/*.js \
        --replace 'alreadyInstalled:!1' 'alreadyInstalled:!0'
    '';
  }
)
