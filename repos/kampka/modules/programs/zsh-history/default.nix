{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.kampka.programs.zsh-history;

  zsh-history = pkgs.callPackage ./../../../pkgs/zsh-history {};

in
{

  options.kampka.programs.zsh-history = {
    enable = mkEnableOption "A CLI to provide enhanced history for your shell";
  };

  config = mkIf cfg.enable {

    environment.systemPackages = [ zsh-history ];

    programs.zsh.interactiveShellInit = ''
      alias hs="command history"
      ZSH_HISTORY_KEYBIND_GET="^r"
      ZSH_HISTORY_KEYBIND_GET_ALL="^r^r"
      ZSH_HISTORY_KEYBIND_GET_BY_DIR="^f"
      ZSH_HISTORY_KEYBIND_ARROW_UP="^p"
      ZSH_HISTORY_KEYBIND_ARROW_DOWN="^n"
      ZSH_HISTORY_AUTO_SYNC=false
      ZSH_HISTORY_FILTER_OPTIONS="--filter-dir --filter-status"

      source ${zsh-history.out}/share/zsh/init.zsh

      # Keybinding seem to be buggy when filter options are set
      # Unsetting options disables columns filters
      # but they are not that useful anyways
      unset ZSH_HISTORY_COLUMNS_GET_ALL
      #unset ZSH_HISTORY_FILTER_OPTIONS
    '';
  };
}
