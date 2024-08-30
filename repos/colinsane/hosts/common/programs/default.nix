{ pkgs, ... }:

{
  imports = [
    ./abaddon.nix
    ./aerc.nix
    ./alacritty.nix
    ./alsa-ucm-conf
    ./animatch.nix
    ./assorted.nix
    ./audacity.nix
    ./ausyscall.nix
    ./avahi.nix
    ./bemenu.nix
    ./bitcoin-cli.nix
    ./blast-ugjka
    ./bonsai.nix
    ./brave.nix
    ./brightnessctl.nix
    ./bubblewrap.nix
    ./bunpen.nix
    ./callaudiod.nix
    ./calls.nix
    ./cantata.nix
    ./capsh.nix
    ./captree.nix
    ./catt.nix
    ./celeste64.nix
    ./chatty.nix
    ./conky
    ./cozy.nix
    ./cups.nix
    ./curl.nix
    ./curlftpfs.nix
    ./dbus.nix
    ./dconf.nix
    ./deadd-notification-center
    ./dialect.nix
    ./dino.nix
    ./dissent.nix
    ./dtrx.nix
    ./eg25-control.nix
    ./element-desktop.nix
    ./engrampa.nix
    ./epiphany.nix
    ./errno.nix
    ./evince.nix
    ./exiftool.nix
    ./fcitx5.nix
    ./feedbackd.nix
    ./firefox.nix
    ./firefox-xdg-open.nix
    ./flare-signal.nix
    ./foliate.nix
    ./fontconfig.nix
    ./fractal.nix
    ./free.nix
    ./frozen-bubble.nix
    ./fwupd.nix
    ./g4music.nix
    ./gajim.nix
    ./gdb.nix
    ./gdbus.nix
    ./geary.nix
    ./geoclue-demo-agent.nix
    ./geoclue2.nix
    ./git.nix
    ./gnome-clocks.nix
    ./gnome-feeds.nix
    ./gnome-keyring
    ./gnome-maps.nix
    ./gnome-weather.nix
    ./go2tv.nix
    ./gocryptfs.nix
    ./gpodder.nix
    ./gpsd.nix
    ./gps-share.nix
    ./grimshot.nix
    ./gst-device-monitor.nix
    ./gthumb.nix
    ./gvfs.nix
    ./handbrake.nix
    ./haredoc.nix
    ./helix.nix
    ./htop
    ./iio-sensor-proxy.nix
    ./imagemagick.nix
    ./jellyfin-media-player.nix
    ./kdenlive.nix
    ./keymapp.nix
    ./komikku.nix
    ./koreader
    ./less.nix
    ./lftp.nix
    ./lgtrombetta-compass.nix
    ./libreoffice.nix
    ./lemoa.nix
    ./loupe.nix
    ./mako.nix
    ./megapixels.nix
    ./mepo.nix
    ./mimeo
    ./mimetype.nix
    ./mmcli.nix
    ./mopidy.nix
    ./mpv
    ./msmtp.nix
    ./nautilus.nix
    ./neovim
    ./networkmanager_dmenu
    ./newsflash.nix
    ./nheko.nix
    ./nicotine-plus.nix
    ./nix-index.nix
    ./nix.nix
    ./nmcli.nix
    ./notejot.nix
    ./ntfy-sh.nix
    ./nwg-panel
    ./objdump.nix
    ./obsidian.nix
    ./offlineimap.nix
    ./ols.nix
    ./open-in-mpv.nix
    ./pactl.nix
    ./papers.nix
    ./pidof.nix
    ./pipewire
    ./pkill.nix
    ./planify.nix
    ./portfolio-filemanager.nix
    ./playerctl.nix
    ./ps.nix
    ./qmk-udev-rules.nix
    ./rhythmbox.nix
    ./ripgrep.nix
    ./rofi
    ./rsyslog
    ./rtkit.nix
    ./s6-rc.nix
    ./sane-deadlines.nix
    ./sane-input-handler
    ./sane-open.nix
    ./sane-private-unlock-remote.nix
    ./sane-screenshot.nix
    ./sane-scripts.nix
    ./sane-secrets-unlock.nix
    ./sane-sysload.nix
    ./sane-theme.nix
    ./sanebox.nix
    ./satellite.nix
    ./schlock.nix
    ./seatd.nix
    ./sfeed.nix
    ./shadow.nix
    ./signal-desktop.nix
    ./splatmoji.nix
    ./spot.nix
    ./spotify.nix
    ./steam.nix
    ./stepmania.nix
    ./strings.nix
    ./sublime-music.nix
    ./supertuxkart.nix
    ./sway
    ./sway-autoscaler
    ./swayidle.nix
    ./swaylock.nix
    ./swaynotificationcenter
    ./switchboard.nix
    ./syshud.nix
    ./tangram.nix
    ./tor-browser.nix
    ./tuba.nix
    ./unl0kr
    ./via.nix
    ./visidata.nix
    ./vlc.nix
    ./wally-cli.nix
    ./waybar
    ./waylock.nix
    ./where-am-i.nix
    ./wike.nix
    ./wine.nix
    ./wireplumber.nix
    ./wireshark.nix
    ./wvkbd.nix
    ./xarchiver.nix
    ./xdg-desktop-portal.nix
    ./xdg-desktop-portal-gnome
    ./xdg-desktop-portal-gtk.nix
    ./xdg-desktop-portal-wlr.nix
    ./xdg-terminal-exec.nix
    ./xdg-utils.nix
    ./youtube-tui.nix
    ./zathura.nix
    ./zeal.nix
    ./zecwallet-lite.nix
    ./zulip.nix
    ./zsa-udev-rules.nix
    ./zfs-tools.nix
    ./zsh
  ];

  # XXX: this might not be necessary. try removing this and cacert.unbundled (servo)?
  environment.etc."ssl/certs".source = "${pkgs.cacert.unbundled}/etc/ssl/certs/*";
}
