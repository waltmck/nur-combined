{ ... }:
{
  sane.programs.komikku = {
    sandbox.method = "bwrap";  # TODO:sandbox untested
    sandbox.wrapperType = "wrappedDerivation";
    sandbox.net = "clearnet";
    sandbox.whitelistDri = true;  #< required
    sandbox.whitelistWayland = true;

    secrets.".local/share/komikku/keyrings/plaintext.keyring" = ../../../secrets/common/komikku_accounts.json.bin;
    # downloads end up here, and without the toplevel database komikku doesn't know they exist.
    persist.byStore.plaintext = [
      # also writes to ~/.cache/komikku
      ".local/share/komikku"
    ];
  };
}
