{
  lib,
  stdenv,
  fetchFromGitHub,
  python3Packages,
  geoarrow-c,
}:

python3Packages.buildPythonPackage rec {
  pname = "geoarrow-pyarrow";
  version = "0.1.2";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "geoarrow";
    repo = "geoarrow-python";
    rev = "v${version}";
    hash = "sha256-Ni+GKTRhRDRHip1us3OZPuUhHQCNU7Nap865T/+CU8Y=";
  };

  sourceRoot = "${src.name}/geoarrow-pyarrow";

  build-system = with python3Packages; [ setuptools-scm ];

  propagatedBuildInputs = with python3Packages; [
    geoarrow-c
    pyarrow
    pyarrow-hotfix
  ];

  meta = with lib; {
    description = "Python implementation of the GeoArrow specification";
    homepage = "https://github.com/geoarrow/geoarrow-python";
    license = licenses.asl20;
    maintainers = [ maintainers.sikmir ];
  };
}
