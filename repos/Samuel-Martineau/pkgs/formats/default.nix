{ lib, pkgs }:
rec {
  plist = { binary ? false }: {

    generate = name: value: pkgs.callPackage
      ({ runCommand, libplist }: runCommand name
        {
          nativeBuildInputs = [ libplist ];
          value = builtins.toJSON value;
          passAsFile = [ "value" ];
        } ''
        plistutil -f ${if binary then "bin" else "xml"} -i "$valuePath" -o "$out"
      '')
      { };

    type = with lib.types; let
      plistAtom = nullOr oneOf [
        bool
        int
        float
        str
        path
      ];
      valueType = (oneOf [
        (attrsOf plistAtom)
        (listOf plistAtom)
      ]) // {
        description = "Property list value";
      };
    in
    valueType;

  };
}
