{ lib
, stdenv
, fetchFromGitHub
, cmake
, pkg-config
, systemdLibs
, avahi
, protobuf
, jsoncpp
, boost
, libnetfilter_queue
, libnfnetlink
, nodejs
, buildNpmPackage
}:
let
  pname = "ot-br-posix";
  version = "unstable-2024-07-26";

  src = fetchFromGitHub {
      owner = "openthread";
      repo = "ot-br-posix";
      rev = "6f3dfdc7a7856086831a4e234812591f2a7cd793";
      hash = "sha256-cp/CJB8ykQvbfSd/qjpGjIQ7ePRVSM+97YRacqUzw/c=";
      fetchSubmodules = true;
  };

  # hass-addons contains a few patches
  hass-addons = fetchFromGitHub {
    owner = "home-assistant";
    repo = "addons";
    rev = "583a62a69fa92ca8fdf9a2f298270a50bb3663a1";
    hash = "sha256-u+lvU7mlJZqCCDIT4n7WnHyzAd0nZCh9Ddvqjs4SkHA=";
  };

  frontendModules = buildNpmPackage {
    pname = "${pname}-frontend";
    inherit version;
    src = "${src}/src/web/web-service/frontend";
    npmDepsHash = "sha256-7UVfPICyIbHEClpr3p7eDR46OUzS8mVf6P7phnDpVLk=";
    dontNpmBuild = true;
  };
in
stdenv.mkDerivation {

  inherit pname version src;

  # warning _FORTIFY_SOURCE requires compiling with optimization (-O)
  env.NIX_CFLAGS_COMPILE = "-O";

  patches = [
    ./dont-install-systemd-units.patch
    ./dont-use-boost-static-libs.patch
    "${hass-addons}/openthread_border_router/0002-rest-support-deleting-the-dataset.patch"
    "${hass-addons}/openthread_border_router/0003-openthread-set-netif-route-metric-lower.patch"
  ];

  postPatch = ''
    pushd third_party/openthread/repo
      patch -p1 -i "${hass-addons}/openthread_border_router/0001-channel-monitor-disable-by-default.patch"
    popd
  '';

  nativeBuildInputs = [
    pkg-config
    cmake
    nodejs
  ];

  # Adding npmConfigHook and manually passing fetchNpmDeps was resulting in ENOTCACHED errors
  postConfigure = ''
    ln -sf ${frontendModules}/lib/node_modules/otbr-web/node_modules ./src/web/web-service/frontend/
  '';

  buildInputs =[
    avahi
    systemdLibs
    protobuf
    jsoncpp
    boost
    libnetfilter_queue
    libnfnetlink
  ];

  postInstall = ''
    mkdir -p $out/bin
    cp ${src}/script/otbr-firewall $out/bin/
    chmod +x $out/bin/otbr-firewall

    # Patch the firewall script so we can run it within the systemd start script
    sed -i 's/THREAD_IF=.*//' $out/bin/otbr-firewall
    sed -i 's/.*init-functions//' $out/bin/otbr-firewall
    sed -i 's/.*vars\.sh//' $out/bin/otbr-firewall
  '';

  cmakeFlags = [
    # These defaults are from "examples/platforms/raspbian/default"
    (lib.cmakeBool "OTBR_REST" true)
    (lib.cmakeBool "BUILD_TESTING" false)

    # Needs npm to build the frontend code, that's another day's project
    (lib.cmakeBool "OTBR_WEB" true)
    (lib.cmakeBool "OTBR_NAT64" true)
    (lib.cmakeBool "OTBR_BACKBONE_ROUTER" true)
    (lib.cmakeBool "OTBR_BORDER_ROUTING" true)
    (lib.cmakeBool "OTBR_DBUS" false)
    (lib.cmakeBool "OTBR_TREL" true)


    # From _otbr
    (lib.cmakeBool "OTBR_DNSSD_DISCOVERY_PROXY" true)
    (lib.cmakeBool "OTBR_SRP_ADVERTISING_PROXY" true)
    (lib.cmakeBool "OTBR_DUA_ROUTING" true)
    (lib.cmakeBool "OTBR_COVERAGE" true)
    (lib.cmakeBool "OTBR_DNS_UPSTREAM_QUERY" true)

    # Turning on random flags until I can pair the damn lights
    (lib.cmakeBool "OT_DUA" true)
    (lib.cmakeBool "OT_MLR" true)
    (lib.cmakeBool "OT_ECDSA" true)
    (lib.cmakeBool "OT_SERVICE" true)
    (lib.cmakeBool "OT_ANYCAST_LOCATOR" true)
    (lib.cmakeBool "OT_COVERAGE" true)
    (lib.cmakeBool "OT_DNS_CLIENT" true)
    (lib.cmakeBool "OT_NETDATA_PUBLISHER" true)
    (lib.cmakeBool "OT_SLAAC" true)
    (lib.cmakeBool "OT_SRP_CLIENT" true)
    (lib.cmakeBool "OT_FULL_LOGS" true)
    (lib.cmakeBool "OT_UPTIME" true)

    (lib.cmakeBool "OT_CHANNEL_MANAGER" true)
    (lib.cmakeBool "OT_CHANNEL_MONITOR" true)

    # Required by protobuf
    (lib.cmakeFeature "CMAKE_CXX_STANDARD" "17")
  ];

  meta = with lib; {
    description = "A Thread border router for POSIX-based platforms";
    homepage = "https://github.com/openthread/ot-br-posix";
    license = licenses.bsd3;
    maintainers = with maintainers; [ mrene ];
    mainProgram = "ot-ctl";
    platforms = platforms.linux;
  };
}
