{ lib
, fetchFromGitHub
, buildPythonPackage
, pythonOlder
, filelock
, fsspec
, packaging
, pyyaml
, requests
, tqdm
, typing-extensions
}:

buildPythonPackage rec {
  pname = "huggingface-hub";
  version = "0.20.2";
  format = "setuptools";

  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "huggingface";
    repo = "huggingface_hub";
    rev = "refs/tags/v${version}";
    hash = "sha256-LYfkZVoQ+Jph7cyJYOIaAjtH8+fC/w8V+IWAqc1lHp4=";
  };

  propagatedBuildInputs = [
    filelock
    fsspec
    packaging
    pyyaml
    requests
    tqdm
    typing-extensions
  ];

  # Tests require network access.
  doCheck = false;

  pythonImportsCheck = [
    "huggingface_hub"
  ];

  meta = with lib; {
    description = "Download and publish models and other files on the huggingface.co hub";
    homepage = "https://github.com/huggingface/huggingface_hub";
    changelog = "https://github.com/huggingface/huggingface_hub/releases/tag/v${version}";
    license = licenses.asl20;
    maintainers = with maintainers; [ kira-bruneau ];
  };
}
