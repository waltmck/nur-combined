# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
	  (modulesPath + "/installer/scan/not-detected.nix")
  ];

  # Setup keyfile
  #boot.initrd.secrets = {
    #"/crypto_keyfile.bin" = null;
  #};

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  ######################## filesystems #########################

  fileSystems = {
    "/" = {
      label = "main";
   	  fsType = "btrfs";
      options = [ "compress=zstd" "subvol=root" ];
    };

    "/home" = {
      label = "main";
   	  fsType = "btrfs";
      options = [ "compress=zstd" "subvol=home" ];
    };
    "/nix" = {
      label = "main";
   	  fsType = "btrfs";
      options = [ "compress=zstd" "noatime" "subvol=nix" ];
    };

    "/home/me/work" = {
      fsType = "btrfs";
      neededForBoot = false;
      label = "main";
      options = [ "compress=zstd" "noatime" "subvol=work" ];
    };

	  "/boot" = {
  		device = "/dev/disk/by-uuid/2588-2509";
      fsType = "vfat";
    };
  };



##################### bootloader #################################

	# Use the GRUB 2 boot loader.
	boot.loader.grub = {
  		enable = true;
  		version = 2;
  		device = "nodev";
  		efiSupport = true;
		extraConfig = ''
			set timeout=1
		'';
	};

	boot.loader.efi.canTouchEfiVariables = true;

##################### misc #################################

	boot.initrd.luks.devices = {
   	root = {
   		#name = "root";
      	device = "/dev/disk/by-label/crypt";
      	preLVM = true;
      	allowDiscards = true;
   	};
	};

	boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "uas" "sd_mod" "sdhci_pci" ];
	boot.initrd.kernelModules = [ "dm-snapshot" ];
	boot.kernelModules = [ "kvm-intel" ];
	boot.extraModulePackages = [ ];

}
