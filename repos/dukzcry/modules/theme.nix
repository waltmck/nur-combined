{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.theme;
  matches = l: cfg.enable && any (x: x == cfg.theme) l;
  toGtk2File = key: value:
    let
      value' =
        if isString value then "\"${value}\""
        else toString value;
    in
      "${key} = ${value'}";
  toGtk3File = generators.toINI {
    mkKeyValue = key: value: "${key}=${toString value}";
  };
  toSettings = x: mapAttrs' (n: v: nameValuePair
    (if n == "gtk-theme" then
      "gtk-theme-name"
    else if n == "font-name" then
      "gtk-font-name"
    else if n == "cursor-theme" then
      "gtk-cursor-theme-name"
    else if n == "icon-theme" then
      "gtk-icon-theme-name"
    else if n == "cursor-size" then
      "gtk-cursor-theme-size"
    else if n == "color-scheme" then
      "gtk-application-prefer-dark-theme"
    else
      n)
    (if n == "color-scheme" && v == "prefer-dark" then
      "true"
     else if n == "color-scheme" && v == "prefer-light" then
      "false"
     else
       v)
    ) x;
  gtk3 = matches (adwaita ++ breeze);
  gtk2 = cfg.enable && !gtk3;
  adwaita = [ "Adwaita" "Adwaita-dark" "HighContrast" "HighContrastInverse" ];
  breeze = [ "Breeze" ];
  adwaitaAttrs = {
    gtk-theme = cfg.theme;
    font-name = cfg.font;
    cursor-theme = "Adwaita";
    icon-theme = "Adwaita";
    cursor-size = gvariant.mkInt32 cfg.cursorSize;
    color-scheme = if cfg.preferDark then "prefer-dark" else "prefer-light";
  };
  breezeAttrs = {
    gtk-theme = "Breeze";
    font-name = cfg.font;
    cursor-theme = "breeze_cursors";
    icon-theme = if cfg.preferDark then "breeze-dark" else "breeze";
    cursor-size = gvariant.mkInt32 cfg.cursorSize;
    color-scheme = if cfg.preferDark then "prefer-dark" else "prefer-light";
  };
in
{
  options.theme = {
    enable = mkEnableOption "uniform look for Qt and GTK applications";
    theme = mkOption {
      type = types.str;
    };
    font = mkOption {
      type = types.str;
      default = "Cantarell 11";
    };
    cursorSize = mkOption {
      type = types.int;
      default = 24;
    };
    extraPackages = mkOption {
      type = with types; listOf package;
      default = [];
    };
    preferDark = mkEnableOption "dark theme preference";
  };

  config = mkMerge [
    (mkIf cfg.enable {
      programs.dconf.enable = mkDefault true;
      environment.variables.GTK_CSD = "0";
      environment.variables.LD_PRELOAD = "${pkgs.nur.repos.dukzcry.gtk3-nocsd}/lib/libgtk3-nocsd.so.0";
      environment.systemPackages = cfg.extraPackages;
    })
    (mkIf gtk3 {
      environment.variables = {
        QT_QPA_PLATFORMTHEME = "gtk3";
        QT_STYLE_OVERRIDE = cfg.theme;
      };
      environment = {
        systemPackages = [
          (pkgs.runCommand "gtk3-schemas" {} ''
            mkdir -p $out/share
            ln -s ${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}/glib-2.0 $out/share
          '')
        ];
        pathsToLink = [ "/share/glib-2.0" ];
      };
    })
    (mkIf gtk2 {
      environment.variables = {
        QT_QPA_PLATFORMTHEME = "gtk2";
        QT_STYLE_OVERRIDE = "gtk2";
      };
      environment.etc."xdg/gtk-2.0/gtkrc".text =
        concatStringsSep "\n" (
          mapAttrsToList toGtk2File (toSettings adwaitaAttrs)
        );
      programs.dconf.profiles.user.databases = [{
        settings."org/gnome/desktop/interface" = adwaitaAttrs;
      }];
      environment.etc."xdg/gtk-3.0/settings.ini".text = toGtk3File {
        Settings = toSettings adwaitaAttrs;
      };
      environment.etc."xdg/gtk-4.0/gtk.css".text = ''
        @import url("file:///run/current-system/sw/share/themes/${cfg.theme}/gtk-4.0/gtk.css");
      '';
      environment.systemPackages = with pkgs.libsForQt5; with pkgs.qt6Packages; with pkgs.gnome; [ qtstyleplugins qt6gtk2 gnome-themes-extra adwaita-icon-theme ];
    })
    (mkIf (matches adwaita) {
      environment.etc."xdg/gtk-2.0/gtkrc".text =
        concatStringsSep "\n" (
          mapAttrsToList toGtk2File (toSettings adwaitaAttrs)
        );
      programs.dconf.profiles.user.databases = [{
        settings."org/gnome/desktop/interface" = adwaitaAttrs;
      }];
      environment.etc."xdg/gtk-3.0/settings.ini".text = toGtk3File {
        Settings = toSettings adwaitaAttrs;
      };
      # no gtk4 theme
      environment.systemPackages = with pkgs; with pkgs.gnome; [ adwaita-qt adwaita-qt6 gnome-themes-extra adwaita-icon-theme ];
    })
    (mkIf (matches breeze) {
      environment.etc."xdg/gtk-2.0/gtkrc".text =
        concatStringsSep "\n" (
          mapAttrsToList toGtk2File (toSettings breezeAttrs)
        );
      programs.dconf.profiles.user.databases = [{
        settings."org/gnome/desktop/interface" = breezeAttrs;
      }];
      environment.etc."xdg/gtk-3.0/settings.ini".text = toGtk3File {
        Settings = toSettings breezeAttrs;
      };
      environment.etc."xdg/gtk-4.0/gtk.css".text = ''
        @import url("file:///run/current-system/sw/share/themes/${cfg.theme}/gtk-4.0/gtk.css");
      '';
      environment.systemPackages = with pkgs.kdePackages; [ pkgs.kdePackages.breeze.qt5 pkgs.kdePackages.breeze breeze-gtk breeze-icons ];
    })
  ];
}
