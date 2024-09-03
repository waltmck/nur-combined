{ config, lib, pkgs, ... }:

# docs: https://nixos.wiki/wiki/Sway
# sway-config docs: `man 5 sway`
let
  cfg = config.sane.programs.sway;
  enableXWayland = config.sane.programs.xwayland.enabled;
  wrapSway = configuredSway: let
    swayLauncher = pkgs.writeShellScriptBin "sway" ''
      test -e "$(dirname "$SWAYSOCK")" || \
        echo "warning: required directory not found (create it?): $(dirname "$SWAYSOCK")"
      test -e "$(dirname "$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY")" || \
        echo "warning: required directory not found (create it?): $(dirname "$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY")"
      test -e /tmp/.X11-unix || \
        echo "warning: required directory not found (create it?): /tmp/.X11-unix"

      # delete DISPLAY-related vars from env before launch, else sway will try to connect to a remote display.
      # (consider: nested sway sessions, where sway actually has a reason to read these)
      exec env -u DISPLAY -u WAYLAND_DISPLAY \
        "DESIRED_WAYLAND_DISPLAY=$WAYLAND_DISPLAY" \
        ${configuredSway}/bin/sway \
        2>&1
    '';
  in
    pkgs.symlinkJoin {
      inherit (configuredSway) meta version;
      name = "sway-wrapped";
      paths = [
        swayLauncher
        configuredSway
      ];
      passthru.sway-unwrapped = configuredSway;
    };

  wlroots = (pkgs.nixpkgs-wayland.wlroots.override {
    # wlroots seems to launch Xwayland itself, and i can't easily just do that myself externally.
    # so in order for the Xwayland it launches to be sandboxed, i need to patch the sandboxed version in here.
    xwayland = config.sane.programs.xwayland.package;
  }).overrideAttrs (upstream: {
    # 2023/09/08: fix so clicking a notification can activate the corresponding window.
    # - test: run dino, receive a message while tabbed away, click the desktop notification.
    #   - if sway activates the dino window (i.e. colors the workspace and tab), then all good
    #   - do all of this with only a touchscreen (e.g. on mobile phone) -- NOT a mouse/pointer
    # 2024/08/12: this patch is still necessary (for moby)
    ## what this patch does:
    # - allows any wayland window to request activation, at any time.
    # - traditionally, wayland only allows windows to request activation if
    #   the client requesting to transfer control has some connection to a recent user interaction.
    #   - e.g. the active window may transfer control to any window
    #   - a window which was very recently active may transfer control to itself
    ## alternative (longer-term) solutions:
    # - fix this class of bug in gtk:
    #   - <https://gitlab.gnome.org/GNOME/gtk/-/merge_requests/5782>
    #   - N.B.: this linked PR doesn't actually fix it
    # - add xdg_activation_v1 support to SwayNC (my notification daemon):
    #   - <https://github.com/ErikReider/SwayNotificationCenter/issues/71>
    #   - mako notification daemon supports activation, can use as a reference
    #     - all of ~30 LoC, looks straight-forward
    #     - however, it's not clear that gtk4 (or dino) actually support this mode of activation.
    #     - i.e. my experience with dino is the same using mako as with SwayNC
    postPatch = (upstream.postPatch or "") + ''
      substituteInPlace types/wlr_xdg_activation_v1.c \
        --replace-fail 'if (token->seat != NULL)' 'if (false && token->seat != NULL)'
    '';
  });
  swayPackage = wrapSway (
    (pkgs.nixpkgs-wayland.sway-unwrapped.override {
      inherit wlroots;
      # about xwayland:
      # - required by many electron apps, though some electron apps support NIXOS_OZONE_WL=1 for native wayland.
      # - when xwayland is enabled, KOreader incorrectly chooses the X11 backend
      #   -> slower; blurrier
      # - xwayland uses a small amount of memory (like 30MiB, IIRC?)
      inherit enableXWayland;
    }).overrideAttrs (upstream: {
      # fix to create SWAYSOCK and WAYLAND_DISPLAY directly in a sandboxable subdirectory:
      # i can't simply move it after creation i think because that would
      # be an unsupported cross-device `mv`?
      postPatch = (upstream.postPatch or "") + ''
        substituteInPlace sway/ipc-server.c --replace-fail \
          '"%s/sway-ipc.%u.%i.sock", dir, getuid(), getpid())' \
          '"%s/sway/sway-ipc.sock", dir)'
        substituteInPlace sway/server.c --replace-fail \
          '"wayland-%u"' '"wl/wayland-%u"'
      '';
    })
  );
in
{
  sane.programs.sway = {
    configOption = with lib; mkOption {
      default = {};
      type = types.submodule {
        options = {
          extra_lines = mkOption {
            type = types.lines;
            description = ''
              extra lines to append to the sway config
            '';
            default = ''
              # XXX: sway needs exclusive control of XF86Audio{Raise,Lower}Volume, so assign this from a block that it can override.
              # TODO: factor the bindings out into proper options and be less hacky?
              bindsym --locked XF86AudioRaiseVolume exec $volume_up
              bindsym --locked XF86AudioLowerVolume exec $volume_down
            '';
          };
          font = mkOption {
            type = types.str;
            default = "pango:monospace 11";
            description = ''
              default font (for e.g. window titles)
            '';
          };
          locker = mkOption {
            type = types.str;
            default = "swaylock";
            description = ''
              name of program to use as the screenlocker
            '';
            example = "schlock";
          };
          mod = mkOption {
            type = types.str;
            default = "Mod4";
            description = ''
              Super key (for non-application shortcuts).
              - "Mod1" for Alt
              - "Mod4" for logo key
            '';
          };
          workspace_layout = mkOption {
            type = types.str;
            default = "default";
            description = ''
              how to arrange windows within new workspaces, by default:
              - "default" (split)
              - "tabbed"
              - etc
            '';
          };
        };
      };
    };

    packageUnwrapped = swayPackage;
    suggestedPrograms = [
      "guiApps"
      "blueberry"  # GUI bluetooth manager
      "brightnessctl"
      "conky"  # for a nice background
      # "fcitx5"  # input method; emoji  # TODO(2024/05/10): this broke 2-ish weeks ago, glitches input into any textbox, possibly only when xwayland is enabled?
      "fontconfig"
      # "gnome.gnome-bluetooth"  # XXX(2023/05/14): broken
      # "gnome.gnome-control-center"  # XXX(2023/06/28): depends on webkitgtk4_1
      "networkmanager_dmenu"
      "nwg-panel"
      "pipewire"
      "playerctl"  # for waybar & particularly to have playerctld running
      "rofi"  # menu/launcher
      "rofi-snippets"
      "s6-rc"  # used by sway config
      "sane-screenshot"
      "sane-open"
      "sane-theme"
      "seatd"
      # "splatmoji"  # used by sway config
      "sway-contrib.grimshot"  # used by sway config
      "swayidle"  # enable if you need it
      "swaynotificationcenter"  # notification daemon
      "switchboard"  # network/bluetooth/sound control panel
      "syshud"  # volume notifier
      "unl0kr"  # greeter
      # "waybar"
      "wdisplays"  # like xrandr
      "wireplumber"  # used by sway config
      "wl-clipboard"
      "xdg-desktop-portal"
      "xdg-desktop-portal-gnome"
      # xdg-desktop-portal-gtk provides portals for:
      # - org.freedesktop.impl.portal.Access
      # - org.freedesktop.impl.portal.Account
      # - org.freedesktop.impl.portal.DynamicLauncher
      # - org.freedesktop.impl.portal.Email
      # - org.freedesktop.impl.portal.FileChooser
      # - org.freedesktop.impl.portal.Inhibit
      # - org.freedesktop.impl.portal.Notification
      # - org.freedesktop.impl.portal.Print
      # and conditionally (i.e. unless buildPortalsInGnome = false) for:
      # - org.freedesktop.impl.portal.AppChooser (@appchooser_iface@)
      # - org.freedesktop.impl.portal.Lockdown (@lockdown_iface@)
      # - org.freedesktop.impl.portal.Settings (@settings_iface@)
      # - org.freedesktop.impl.portal.Wallpaper (@wallpaper_iface@)
      # "xdg-desktop-portal-gtk"
      # xdg-desktop-portal-wlr provides portals for screenshots/screen sharing
      "xdg-desktop-portal-wlr"
      "xdg-terminal-exec"  # used by sway config
    ] ++ [
      cfg.config.locker
    ];

    sandbox.method = "bunpen";
    sandbox.net = "all";  # TODO: shouldn't be needed! but without this, mouse/kb hotplug doesn't work.
    sandbox.whitelistAudio = true;  # it runs playerctl directly
    sandbox.whitelistDbus = [ "system" "user" ];  # to e.g. launch apps
    sandbox.whitelistDri = true;
    sandbox.whitelistS6 = true;  #< for Super+L to start the screen locker service
    sandbox.whitelistX = true;  # sway invokes xwayland itself
    sandbox.whitelistWayland = true;
    sandbox.extraRuntimePaths = [
      "sway"
    ];
    sandbox.extraPaths = [
      # "/dev/input"
      "/run/seatd"  #< required if not using `logind` systemd login manager
      # "/run/systemd/sessions"
      "/run/udev"
      "/sys/class/backlight"
      "/sys/class/drm"
      "/sys/class/input"
      "/sys/dev/char"
      "/sys/devices"
    ];
    sandbox.extraHomePaths = [
      # bind ALL of ~/.config/sway into the sandbox instead of just the individual configs.
      # this way `swaymsg -- reload` can work even if the fd for ~/.config/sway/config changes.
      ".config/sway"
    ];

    fs.".config/xdg-desktop-portal/sway-portals.conf".symlink.text = ''
      # portals.conf docs: <https://flatpak.github.io/xdg-desktop-portal/docs/portals.conf.html>
      [preferred]
      default=wlr;gnome;gtk
    '';

    fs.".config/sway/config".symlink.target = pkgs.substituteAll {
      src = ./config;
      inherit (cfg.config)
        extra_lines
        font
        locker
        mod
        workspace_layout
      ;
      xwayland = if enableXWayland then "enable" else "disable";
    };

    env.XDG_CURRENT_DESKTOP = "sway";
    # sway defaults to auto-generating a unix domain socket named "sway-ipc.$UID.NNNN.sock",
    # which allows for multiple sway sessions under the same user.
    # but the unpredictability makes static sandboxing & such difficult, so hardcode it.
    # place it in a subdirectory for the same reason:
    env.SWAYSOCK = "$XDG_RUNTIME_DIR/sway/sway-ipc.sock";
    # TODO: ensure this is reliable? might not work across sway restarts, etc.
    env.DISPLAY = ":0";
    # docs: <https://discourse.ubuntu.com/t/environment-variables-for-wayland-hackers/12750>
    # N.B.: gtk apps support absolute paths for this; webkit apps (e.g. geary) support only relative paths (relative to $XDG_RUNTIME_DIR)
    env.WAYLAND_DISPLAY = "wl/wayland-1";

    services.private-storage.dependencyOf = [ "sway" ];  #< HACK: prevent unl0kr and sway from fighting over the tty
    services.sway = {
      description = "sway: tiling wayland desktop environment";
      partOf = [
        "wayland"
      ] ++ lib.optionals enableXWayland [
        "x11"
      ];
      # partOf = lib.mkMerge [
      #   "wayland"
      #   (lib.mkIf enableXWayland "x11")
      # ];
      command = pkgs.writeShellScript "sway-start" ''
        # have to create these directories before launching sway so that they're available in the sandbox
        mkdir -p "$(dirname "$SWAYSOCK")"
        mkdir -p "$(dirname "$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY")"
        mkdir -p /tmp/.X11-unix  # for Xwayland
        exec sway
      '';
      readiness.waitExists = [ "$SWAYSOCK" "$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY" ];
    };
    # launch all graphical apps by default
    services."graphical-session".partOf = [ "default" ];
  };

  # TODO: this can go elsewhere
  hardware.bluetooth.enable = lib.mkIf cfg.enabled true;
  services.blueman.enable = lib.mkIf cfg.enabled true;

  # gsd provides Rfkill, which is required for the bluetooth pane in gnome-control-center to work
  # services.gnome.gnome-settings-daemon.enable = true;

  # start the components of gsd we need at login
  # systemd.user.targets."org.gnome.SettingsDaemon.Rfkill".wantedBy = [ "graphical-session.target" ];
  # go ahead and `systemctl --user cat gnome-session-initialized.target`. i dare you.
  # the only way i can figure out how to get Rfkill to actually load is to just disable all the shit it depends on.
  # it doesn't actually seem to need ANY of them in the first place T_T
  # systemd.user.targets."gnome-session-initialized".enable = false;

  # bluez can't connect to audio devices unless pipewire is running.
  # a system service can't depend on a user service, so just launch it at graphical-session
}

