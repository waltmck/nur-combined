{ pkgs, ... }:

{
  imports = [
    ./aerc.nix
    ./assorted.nix
    ./chatty.nix
    ./cozy.nix
    ./element-desktop.nix
    ./epiphany.nix
    ./evince.nix
    ./firefox.nix
    ./fontconfig.nix
    ./fractal.nix
    ./fwupd.nix
    ./git.nix
    ./gnome-feeds.nix
    ./gnome-keyring.nix
    ./gpodder.nix
    ./gthumb.nix
    ./helix.nix
    ./imagemagick.nix
    ./jellyfin-media-player.nix
    ./kitty
    ./komikku.nix
    ./koreader
    ./libreoffice.nix
    ./lemoa.nix
    ./megapixels.nix
    ./mepo.nix
    ./mpv.nix
    ./msmtp.nix
    ./neovim.nix
    ./newsflash.nix
    ./nheko.nix
    ./nix-index.nix
    ./obsidian.nix
    ./offlineimap.nix
    ./ripgrep.nix
    ./sfeed.nix
    ./splatmoji.nix
    ./steam.nix
    ./sublime-music.nix
    ./tangram.nix
    ./tuba.nix
    ./vlc.nix
    ./wireshark.nix
    ./xarchiver.nix
    ./zeal.nix
    ./zsh
  ];

  config = {
    # XXX: this might not be necessary. try removing this and cacert.unbundled (servo)?
    environment.etc."ssl/certs".source = "${pkgs.cacert.unbundled}/etc/ssl/certs/*";

  };
}
