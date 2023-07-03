{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.profile.sound;

in
{
  meta.maintainers = [ wolfangaukang ];

  options.profile.sound = {
    enable = mkOption {
      default = false;
      type = types.bool;
      description = ''
        Enables sound
      '';
    };
    enableOSSEmulation  = mkOption {
      default = false;
      type = types.bool;
      description = ''
        Enables ALSA OSS emulation
      '';
    };
    pipewire = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables pipewire
        '';
      };
      enableAlsa32BitSupport = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables 32 Bit support for Alsa
        '';
      };
    };
    pulseaudio = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables pulseaudio
        '';
      };
      audioGroupMembers = mkOption {
        default = [];
        type = types.listOf types.str;
        description = ''
          List of members for the audio group
        '';
      };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      sound = {
        enable = true;
        enableOSSEmulation = mkIf cfg.enableOSSEmulation true;
      };
    }
    (mkIf cfg.pipewire.enable (import ../../profiles/services/pipewire.nix { inherit lib; }))
    (mkIf cfg.pulseaudio.enable {
      hardware.pulseaudio.enable = true;
      users.extraGroups.audio.members = cfg.pulseaudio.audioGroupMembers;
    })
  ]);
}

