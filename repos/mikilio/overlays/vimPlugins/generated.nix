# GENERATED by ./pkgs/applications/editors/vim/plugins/update.py. Do not edit!
{ lib, buildVimPluginFrom2Nix, buildNeovimPlugin, fetchFromGitHub, fetchgit }:

final: prev:
{
  harpoon = buildVimPluginFrom2Nix {
    pname = "harpoon";
    version = "2023-08-13";
    src = fetchFromGitHub {
      owner = "Mikilio";
      repo = "harpoon";
      rev = "7d9f2afcaff69d11ad648bad0c84876911b8279e";
      sha256 = "0lmqn2zzk91dg1xw1zxb8rcv16a0j8ih50ffvka96kmwdxlldrkd";
    };
    meta.homepage = "https://github.com/Mikilio/harpoon/";
  };

  knap = buildVimPluginFrom2Nix {
    pname = "knap";
    version = "2023-08-07";
    src = fetchFromGitHub {
      owner = "Mikilio";
      repo = "knap";
      rev = "9ab1252b992dc8bacc8e82fce683395ac474986f";
      sha256 = "1krddc2mfcjsydkc3dk4a07aafpd0iy4fw6ag67ky4plli6ipcp5";
    };
    meta.homepage = "https://github.com/Mikilio/knap/";
  };

  lsp-zero-nvim = buildVimPluginFrom2Nix {
    pname = "lsp-zero.nvim";
    version = "2023-08-12";
    src = fetchFromGitHub {
      owner = "VonHeikemen";
      repo = "lsp-zero.nvim";
      rev = "04d2bd53ebc490378e25cb399942a5f48f5befd2";
      sha256 = "1n922b6gvx5sbqy07g4nim75553rb7sh4qs649p2l1dfm05xv0da";
    };
    meta.homepage = "https://github.com/VonHeikemen/lsp-zero.nvim/";
  };

  texmagic-nvim = buildVimPluginFrom2Nix {
    pname = "texmagic.nvim";
    version = "2022-05-15";
    src = fetchFromGitHub {
      owner = "jakewvincent";
      repo = "texmagic.nvim";
      rev = "3c0d3b63c62486f02807663f5c5948e8b237b182";
      sha256 = "19r6sdyaxkjmm9k5l97n4fcp5ycx8d3v9kyydxzcpxji5synv2gq";
    };
    meta.homepage = "https://github.com/jakewvincent/texmagic.nvim/";
  };

  netrw-nvim = buildVimPluginFrom2Nix {
    pname = "netrw.nvim";
    version = "2023-06-29";
    src = fetchFromGitHub {
      owner = "prichrd";
      repo = "netrw.nvim";
      rev = "596435bd2f5b0162b86c97ca8244e2b0862d3a4a";
      sha256 = "13q841gj7v1iqj0g7iy8216nxp9v6rlzsm6gxmz2bqcl715gggyz";
    };
    meta.homepage = "https://github.com/prichrd/netrw.nvim/";
  };


}
