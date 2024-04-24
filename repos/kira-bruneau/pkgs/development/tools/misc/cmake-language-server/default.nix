{ lib
, stdenv
, buildPythonApplication
, pythonOlder
, fetchFromGitHub
, pdm-backend
, cmake-format
, pygls
, cmake
, pytest-datadir
, pytestCheckHook
}:

buildPythonApplication rec {
  pname = "cmake-language-server";
  version = "0.1.10";
  format = "pyproject";

  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "regen100";
    repo = "cmake-language-server";
    rev = "refs/tags/v${version}";
    hash = "sha256-9fnyDJm8rUl+7g4FrdMykPpQOcww2M6IPWH/3qVeJX4=";
  };

  patches = [
    # Test timeouts occasionally cause the build to fail
    ./disable-test-timeouts.patch
  ];

  nativeBuildInputs = [
    pdm-backend
  ];

  propagatedBuildInputs = [
    cmake-format
    pygls
  ];

  nativeCheckInputs = [
    cmake
    cmake-format
    pytest-datadir
    pytestCheckHook
  ];

  # version.py generated by pdm, no idea why it's not present in test phase
  # https://github.com/regen100/cmake-language-server/blob/68bbc8187b6110a75f498647af7c44df790ffa87/pyproject.toml#L35-L36
  preCheck = ''
    echo "__version__ = \"$PDM_BUILD_SCM_VERSION\"" >  cmake_language_server/version.py
  '';

  postCheck = ''
    rm cmake_language_server/version.py
  '';

  dontUseCmakeConfigure = true;

  pythonImportsCheck = [
    "cmake_language_server"
  ];

  meta = with lib; {
    description = "CMake LSP Implementation";
    homepage = "https://github.com/regen100/cmake-language-server";
    changelog = "https://github.com/regen100/cmake-language-server/releases/tag/v${version}";
    license = licenses.mit;
    maintainers = with maintainers; [ kira-bruneau ];
    mainProgram = "cmake-language-server";

    # pandas (required by poetry) is marked as broken on i686
    broken = stdenv.isi686;
  };
}
