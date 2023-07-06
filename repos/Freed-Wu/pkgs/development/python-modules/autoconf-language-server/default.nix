{ mySources
, python3
, lib
, autoconf
, automake
, setuptools-generate
}:

with python3.pkgs;

buildPythonPackage rec {
  inherit (mySources.autoconf-language-server) pname version src;
  format = "pyproject";
  disabled = pythonOlder "3.6";
  propagatedBuildInputs = [
    pygls
    platformdirs
    autoconf
    automake
  ];
  nativeCheckInputs = [
    setuptools-generate
  ];
  pythonImportsCheck = [
    "autoconf_language_server"
  ];

  meta = with lib; {
    homepage = "https://autoconf-language-server.readthedocs.io";
    description = "autoconf language server";
    license = licenses.gpl3;
    maintainers = with maintainers; [ Freed-Wu ];
    platforms = platforms.unix;
  };
}
