This implements an ieee 802.15.4 sniffer in the 2.4ghz band using O-QPSK demod. The main entrypoint implements the wireshark extcap protocol, which will make it appear in the list of interfaces if it's located in its `lib/extpath` folder, or if it's referenced by `WIRESHARK_EXTCAP_DIR`.