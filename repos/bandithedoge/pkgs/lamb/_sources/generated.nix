# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  lamb = {
    pname = "lamb";
    version = "v2.1.0";
    src = fetchFromGitHub {
      owner = "magnetophon";
      repo = "lamb-rs";
      rev = "v2.1.0";
      fetchSubmodules = true;
      sha256 = "sha256-o4BhCVIqsOREDsC7F4GPtdQKCfofyiE/uPnVKmuBGAs=";
    };
    cargoLock."Cargo.lock" = {
      lockFile = ./lamb-v2.1.0/Cargo.lock;
      outputHashes = {
        "assert_no_alloc-1.1.2" = "sha256-kCwtn0uONDTlDqfCpYtjB3spYM89qWjkzUOdcGjtY3c=";
        "baseview-0.1.0" = "sha256-89+5/TF9U7N4ODF1OOls1hnJHT0pkN2t9UakUaSitwY=";
        "vst3-com-0.1.0" = "sha256-tKWEmJR9aRpfsiuVr0K8XXYafVs+CzqCcP+Ea9qvZ7Y=";
        "nih_plug-0.0.0" = "sha256-n1qe6Mv7lgee9g6TX5a6cMhBn3prLm6FavqB84SILVM=";
        "cyma-0.1.0" = "sha256-QlM02uHwg7QmXUVOARmQWRuXeCfy6/2nrpQELdLF8Bo=";
        "faust-build-0.1.0" = "sha256-iVhX7FgNa9jBkUaoDZq25nrMAQefnSPKD45qxty2vXk=";
        "clap-sys-0.3.0" = "sha256-svq9DMqzKVZCU07FiOIsdCt78BJctwlPobSlNZGeBxQ=";
        "cosmic-text-0.8.0" = "sha256-vNdPMSyyzsdHqqn4cqALKrrjmTV0Zzmj6KdmnW4sQBc=";
        "nih_plug_assets-0.1.0" = "sha256-mGyC7rHvPnrtNxd/xLLnPCG4HzJnw1dYZaltEsCVCrA=";
        "faust-types-0.1.0" = "sha256-iVhX7FgNa9jBkUaoDZq25nrMAQefnSPKD45qxty2vXk=";
        "selectors-0.23.0" = "sha256-ulW5FEQRxURZ8P71Z4UOqodL9d2GtA053hDDubNovwk=";
        "reflink-0.1.3" = "sha256-1o5d/mepjbDLuoZ2/49Bi6sFgVX4WdCuhGJkk8ulhcI=";
      };
    };
  };
}
