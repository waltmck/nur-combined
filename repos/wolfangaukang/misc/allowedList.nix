{ getName
, licenses
}:

{
  allowUnfreePredicate = pkg: builtins.elem (getName pkg) [
    "burpsuite-2023.10.1.1"
    "Oracle_VM_VirtualBox_Extension_Pack-7.0.14.vbox-extpack"
    "video-downloadhelper"
    "vmware-workstation"
    "zerotierone-1.12.2"
  ];
  allowlistedLicenses = with licenses; [
    bsl11
    virtualbox-puel
  ];
}
