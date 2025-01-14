{ pkgs, ... }:
with pkgs;
[
  eva
  paperback
  amberol
  mako
  xwayland-satellite
  # qq
  chromium
  discord
  celeste
  stellarium
  obsidian
  celluloid
  thiefmd
  # wpsoffice
  fractal
  mari0
  # anyrun
  # factorio
  loupe
  geo
  gedit
  # logseq
  # jetbrains.pycharm-professional
  # jetbrains.idea-ultimate
  # jetbrains.clion
  # jetbrains.rust-rover

  # bottles

  kooha # recorder

  typst
  # blender-hip
  ruffle

  # fractal

  # yuzu-mainline
  # photoprism

  virt-manager
  xdg-utils
  hyfetch

  # microsoft-edge
  dosbox-staging
  meld
  # yubioath-flutter

  gimp
  imv

  veracrypt
  openpgp-card-tools
  tutanota-desktop

  # davinci-resolve
  cava

  # wpsoffice-cn

  sbctl
  qbittorrent

  protonmail-bridge

  koreader
  cliphist
  pcsctools
  ccid

  yubikey-manager

  xdeltaUnstable

  # feeluown
  # feeluown-bilibili
  # # feeluown-local
  # feeluown-netease
  # feeluown-qqmusic

  chntpw
  gkraken
  libnotify

  # Perf
  stress
  s-tui
  mprime

  # reader
  calibre
  mdbook
  sioyek
  zathura
  foliate

  # file
  filezilla
  file
  lapce
  kate
  # cinnamon.nemo
  nautilus
  gnome-boxes
  evince
  # zathura

  # social
  # discord
  materialgram
  element-desktop-wayland
  # thunderbird
  # fluffychat
  scrcpy

  alacritty
  rio
  appimage-run
  tofi
  # zoom-us
  # gnomecast
  tetrio-desktop

  ffmpeg_7-full

  foot

  brightnessctl

  fuzzel
  swaybg
  wl-clipboard
  wf-recorder
  grim
  slurp

  mongodb-compass
  tor-browser-bundle-bin

  vial

  android-tools
  zellij
  # netease-cloud-music-gtk
  cmatrix
  termius
  # kotatogram-desktop
  nmap
  lm_sensors

  feh
  pamixer
  sl
  ncpamixer
  # texlive.combined.scheme-full
  vlc
  bluedevil
  julia-bin
  prismlauncher
]
++ (with pkgs; [
  rust-analyzer
  # nil
  nixd
  nil
  shfmt
  nixfmt-rfc-style
  # taplo
  rustfmt
  clang-tools
  # haskell-language-server
  cmake-language-server
  arduino-language-server
  typst-lsp
  vhdl-ls
  delve
  python311Packages.python-lsp-server
  tinymist
])
++ (with pkgs.nodePackages_latest; [
  vscode-langservers-extracted
  bash-language-server
  vls
  prettier
])
++ (with pkgs; [ fluent-icon-theme ])
++ [
  (writeTextFile {
    name = "index.theme";
    destination = "/share/icons/default/index.theme";
    # Set name in icons theme, for compatibility with AwesomeWM etc. See:
    # https://github.com/nix-community/home-manager/issues/2081
    # https://wiki.archlinux.org/title/Cursor_themes#XDG_specification
    text = ''
      [Icon Theme]
      Name=Default
      Comment=Default Cursor Theme
      Inherits=graphite-light-nord
    '';
  })
]
