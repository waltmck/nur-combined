{ lib, python3, fetchPypi }:

python3.pkgs.buildPythonPackage rec {
  pname = "halmos";
  version = "0.1.14";
  pyproject = true;
  doCheck = false;

  nativeBuildInputs = with python3.pkgs; [
    z3-solver
  ];
  
  src = fetchPypi {
    inherit pname version;
    hash = "sha256-Va5gwyRePGHnFr3jtP1ec3diAQExXfVbwrrMpzV9euc=";
  };
  
  build-system = with python3.pkgs; [
    setuptools
    setuptools-scm
  ];

  pythonRemoveDeps = [ "z3-solver" ]; # https://github.com/NixOS/nixpkgs/blob/1d28f484f4a92f6ef8facea80ea4e3fe3aa153bc/pkgs/development/python-modules/model-checker/default.nix#L24-L25
  
  dependencies = with python3.pkgs; [
    sortedcontainers
    z3-solver
    toml
  ] ++ python3.pkgs.z3-solver.requiredPythonModules;
  
  meta = {
    broken = false;
    description = "A symbolic testing tool for EVM smart contracts";
    homepage = "https://github.com/a16z/halmos";
    platforms = [ "x86_64-linux" ];
    license = lib.licenses.agpl3Only;
  };
}
