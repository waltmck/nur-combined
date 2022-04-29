# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl }:
{
  cf-terraforming = {
    pname = "cf-terraforming";
    version = "v0.7.3";
    src = fetchgit {
      url = "https://github.com/cloudflare/cf-terraforming";
      rev = "v0.7.3";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "194502nz85ffjlq2jhgapvg6llqkdnr5vxhfsf8z73rgc9lrr30r";
    };
  };
  clash-for-windows = {
    pname = "clash-for-windows";
    version = "0.19.17";
    src = fetchurl {
      url = "https://github.com/Fndroid/clash_for_windows_pkg/releases/download/0.19.17/Clash.for.Windows-0.19.17-x64-linux.tar.gz";
      sha256 = "1fjha671ddy6msvr8rk3j9ch83js3g8i1xw8isqnr6r8x7r7caym";
    };
  };
  clash-for-windows-icon = {
    pname = "clash-for-windows-icon";
    version = "0";
    src = fetchurl {
      url = "https://web.archive.org/web/20211210004725if_/https://docs.cfw.lbyczf.com/favicon.ico";
      sha256 = "1zd453mwrlc9kafagyvmj9i8vd5a4akp9srbsy9mxa48x77ckqp2";
    };
  };
  clash-premium-aarch64-linux = {
    pname = "clash-premium-aarch64-linux";
    version = "2022.04.17";
    src = fetchurl {
      url = "https://github.com/Dreamacro/clash/releases/download/premium/clash-linux-armv8-2022.04.17.gz";
      sha256 = "0g4pcbz16gd9125w6fngkgqk8f0rw0cb1v6rb5r0xx9ffxcnqsw6";
    };
  };
  clash-premium-i686-linux = {
    pname = "clash-premium-i686-linux";
    version = "2022.04.17";
    src = fetchurl {
      url = "https://github.com/Dreamacro/clash/releases/download/premium/clash-linux-386-2022.04.17.gz";
      sha256 = "030lwwnidqqx85ip7jhn794ycj5a7vv6wdl72paf85r60jvx7mhk";
    };
  };
  clash-premium-x86_64-darwin = {
    pname = "clash-premium-x86_64-darwin";
    version = "2022.04.17";
    src = fetchurl {
      url = "https://github.com/Dreamacro/clash/releases/download/premium/clash-darwin-amd64-2022.04.17.gz";
      sha256 = "0j1ka3kih2n2qhcvhdk87x7ca5pba58d3wd2b1q0wp5r8w9nppg6";
    };
  };
  clash-premium-x86_64-linux = {
    pname = "clash-premium-x86_64-linux";
    version = "2022.04.17";
    src = fetchurl {
      url = "https://github.com/Dreamacro/clash/releases/download/premium/clash-linux-amd64-2022.04.17.gz";
      sha256 = "0yrqvwlfzkjca1wb0bb40rn4333dgn0had9hikwam63m3sifmz1b";
    };
  };
  commit-notifier = {
    pname = "commit-notifier";
    version = "573c1eb7eabc97aa06e0e9ad85f5148110749876";
    src = fetchgit {
      url = "https://github.com/linyinfeng/commit-notifier.git";
      rev = "573c1eb7eabc97aa06e0e9ad85f5148110749876";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "0al8rvczn99hymhnanfij2b3b35gzg59v2q24swsfrky625g08i6";
    };
    cargoLock = {
      lockFile = ./commit-notifier-573c1eb7eabc97aa06e0e9ad85f5148110749876/Cargo.lock;
      outputHashes = { };
    };
  };
  dot-tar = {
    pname = "dot-tar";
    version = "08f3652b54e8ee021bba933952df56aee22910b3";
    src = fetchgit {
      url = "https://github.com/linyinfeng/dot-tar.git";
      rev = "08f3652b54e8ee021bba933952df56aee22910b3";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "0wl2nhp1ri32mpq6jgvnxi62qg5m841vqi6zdymlfilsiwjamq43";
    };
    cargoLock = {
      lockFile = ./dot-tar-08f3652b54e8ee021bba933952df56aee22910b3/Cargo.lock;
      outputHashes = { };
    };
  };
  dpt-rp1-py = {
    pname = "dpt-rp1-py";
    version = "v0.1.16";
    src = fetchgit {
      url = "https://github.com/janten/dpt-rp1-py";
      rev = "v0.1.16";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "0zvf09b9rzpx5b0w81ziqd7v321hfhgsgvshdx23karj2hf75bvj";
    };
  };
  icalingua-plus-plus = {
    pname = "icalingua-plus-plus";
    version = "v2.6.2";
    src = fetchurl {
      url = "https://github.com/icalingua-plus-plus/icalingua-plus-plus/releases/download/v2.6.2/app-x86_64.asar";
      sha256 = "01w07w5yj8vxkizacaxkqjdnlhbd6sx80rslh2qbl9z2brkglk3s";
    };
  };
  icalingua-plus-plus-aur = {
    pname = "icalingua-plus-plus-aur";
    version = "98d28c0999eddc611e2cf4c69944f67412973348";
    src = fetchgit {
      url = "https://aur.archlinux.org/icalingua++.git";
      rev = "98d28c0999eddc611e2cf4c69944f67412973348";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "0iqdyv0j89xksfcnc3p0swckh4jljgddgs669js49bf4c6a27a4y";
    };
  };
  pisces = {
    pname = "pisces";
    version = "e45e0869855d089ba1e628b6248434b2dfa709c4";
    src = fetchgit {
      url = "https://github.com/laughedelic/pisces";
      rev = "e45e0869855d089ba1e628b6248434b2dfa709c4";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "073wb83qcn0hfkywjcly64k6pf0d7z5nxxwls5sa80jdwchvd2rs";
    };
  };
  plugin-bang-bang = {
    pname = "plugin-bang-bang";
    version = "f969c618301163273d0a03d002614d9a81952c1e";
    src = fetchgit {
      url = "https://github.com/oh-my-fish/plugin-bang-bang";
      rev = "f969c618301163273d0a03d002614d9a81952c1e";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "1r3d4wgdylnc857j08lbdscqbm9lxbm1wqzbkqz1jf8bgq2rvk03";
    };
  };
  plugin-git = {
    pname = "plugin-git";
    version = "2a3e35c05bdc5b9005f917d5281eb866b2e13104";
    src = fetchgit {
      url = "https://github.com/jhillyerd/plugin-git";
      rev = "2a3e35c05bdc5b9005f917d5281eb866b2e13104";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "09y2i21ih6rfdx2j75cfwqh045658ylasj9385zgc7dj3qh8cs5m";
    };
  };
  replay-fish = {
    pname = "replay-fish";
    version = "1.2.0";
    src = fetchgit {
      url = "https://github.com/jorgebucaran/replay.fish";
      rev = "1.2.0";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "1aa3a7jdb8a9z9jd9ckf449zmf7cl7yl47yp94srqj4iv1amizs3";
    };
  };
  telegram-send = {
    pname = "telegram-send";
    version = "693a555dd644042bc83e983607c0f81b1bb0a7e4";
    src = fetchgit {
      url = "https://github.com/rahiel/telegram-send.git";
      rev = "693a555dd644042bc83e983607c0f81b1bb0a7e4";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "15mg87rq3fnmphyrpff88nw1kvfln55r418sv1h1mr9cvkyvy0jg";
    };
  };
  trojan = {
    pname = "trojan";
    version = "v1.16.0";
    src = fetchgit {
      url = "https://github.com/trojan-gfw/trojan";
      rev = "v1.16.0";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "0v24hy46vmbx4yjnf49w2ib5l893b19imykk86zbyj1sfh8ijakw";
    };
  };
  vlmcsd = {
    pname = "vlmcsd";
    version = "svn1113";
    src = fetchgit {
      url = "https://github.com/Wind4/vlmcsd";
      rev = "svn1113";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "19qfw4l4b5vi03vmv9g5i7j32nifvz8sfada04mxqkrqdqxarb1q";
    };
  };
  wemeet = {
    pname = "wemeet";
    version = "2.8.0.3";
    src = fetchurl {
      url = "https://updatecdn.meeting.qq.com/cos/3cdd365cd90f221fb345ab73c4746e1f/TencentMeeting_0300000000_2.8.0.3_x86_64_default.publish.deb";
      sha256 = "17w5lw6yk3655p6qw4myfhypxsp2fmx5jjl0q47v18w8yvh6d87g";
    };
  };
  yacd = {
    pname = "yacd";
    version = "v0.3.4";
    src = fetchurl {
      url = "https://github.com/haishanh/yacd/releases/download/v0.3.4/yacd.tar.xz";
      sha256 = "14q1wp3bdl474f6jwhykvr3409f18xmwhkzndvk6rlgidxvq6in2";
    };
  };
}
