# This file has been generated by node2nix 1.7.0. Do not edit!

{nodeEnv, fetchurl, fetchgit, globalBuildInputs ? []}:

let
  sources = {
    "@types/estree-0.0.41" = {
      name = "_at_types_slash_estree";
      packageName = "@types/estree";
      version = "0.0.41";
      src = fetchurl {
        url = "https://registry.npmjs.org/@types/estree/-/estree-0.0.41.tgz";
        sha512 = "rIAmXyJlqw4KEBO7+u9gxZZSQHaCNnIzYrnNmYVpgfJhxTqO0brCX0SYpqUTkVI5mwwUwzmtspLBGBKroMeynA==";
      };
    };
    "@types/node-13.1.0" = {
      name = "_at_types_slash_node";
      packageName = "@types/node";
      version = "13.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/@types/node/-/node-13.1.0.tgz";
        sha512 = "zwrxviZS08kRX40nqBrmERElF2vpw4IUTd5khkhBTfFH8AOaeoLVx48EC4+ZzS2/Iga7NevncqnsUSYjM4OWYA==";
      };
    };
    "acorn-7.1.0" = {
      name = "acorn";
      packageName = "acorn";
      version = "7.1.0";
      src = fetchurl {
        url = "https://registry.npmjs.org/acorn/-/acorn-7.1.0.tgz";
        sha512 = "kL5CuoXA/dgxlBbVrflsflzQ3PAas7RYZB52NOm/6839iVYJgKMJ3cQJD+t2i5+qFa8h3MDpEOJiS64E8JLnSQ==";
      };
    };
  };
  args = {
    name = "rollup";
    packageName = "rollup";
    version = "1.27.14";
    src = fetchurl { url = "https://registry.npmjs.org/rollup/-/rollup-1.27.14.tgz"; sha1 = "940718d5eec1a6887e399aa0089944bae5c4f377"; };
    dependencies = [
      sources."@types/estree-0.0.41"
      sources."@types/node-13.1.0"
      sources."acorn-7.1.0"
    ];
    buildInputs = globalBuildInputs;
    meta = {
      description = "Next-generation ES module bundler";
      homepage = https://github.com/rollup/rollup;
      license = "MIT";
    };
    production = true;
    bypassCache = true;
    reconstructLock = true;
  };
in
{
  tarball = nodeEnv.buildNodeSourceDist args;
  package = nodeEnv.buildNodePackage args;
  shell = nodeEnv.buildNodeShell args;
}