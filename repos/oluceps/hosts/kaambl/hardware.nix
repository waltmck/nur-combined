# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  inputs',
  self,
  config,
  lib,
  modulesPath,
  pkgs,
  ...
}:

{

  hardware.pulseaudio.enable = lib.mkForce false;
  hardware.graphics = {
    ## amdvlk: an open-source Vulkan driver from AMD
    extraPackages = [ pkgs.amdvlk ];
    extraPackages32 = [ pkgs.driversi686Linux.amdvlk ];
  };

  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];
  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
    fileSystems = [ "/persist" ];
  };

  services.xserver.videoDrivers = [ "amdgpu" ];
  disko.devices = {
    disk = {
      nvme = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-HP_SSD_FX900_Plus_2TB_HBSE53360805325";
        content = {
          type = "gpt";
          partitions = {
            esp = {
              label = "ESP";
              size = "2G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/efi";
              };
            };
            cryptroot = {
              label = "CRYPTROOT";
              size = "1024G";
              content = {
                type = "luks";
                name = "cryptroot";
                settings = {
                  allowDiscards = true;
                  bypassWorkqueues = true;
                  crypttabExtraOpts = [
                    "same-cpu-crypt"
                    "submit-from-crypt-cpus"
                    "fido2-device=auto"
                  ];
                };
                content = {
                  type = "btrfs";
                  extraArgs = [
                    "--label nixos"
                    "-f"
                    "--csum xxhash64"
                    "--features"
                    "block-group-tree"
                  ];
                  subvolumes = {
                    "/persist" = {
                      mountpoint = "/persist";
                      mountOptions = [
                        "compress-force=lzo"
                        "noatime"
                        "discard=async"
                        "space_cache=v2"
                      ];
                    };
                    "/nix" = {
                      mountpoint = "/nix";
                      mountOptions = [
                        "compress-force=lzo"
                        "noatime"
                        "discard=async"
                        "space_cache=v2"
                        "nodev"
                        "nosuid"
                      ];
                    };
                    "/var" = {
                      mountpoint = "/var";
                      mountOptions = [
                        "compress-force=lzo"
                        "noatime"
                        "discard=async"
                        "space_cache=v2"
                      ];
                    };
                    "/persist/tmp" = {
                      mountpoint = "/tmp";
                      mountOptions = [
                        "relatime"
                        "nodev"
                        "nosuid"
                        "discard=async"
                        "space_cache=v2"
                      ];
                    };
                  };
                };
              };
            };
            encryptedSwap = {
              size = "16G";
              content = {
                type = "swap";
                randomEncryption = true;
              };
            };
          };
        };
      };
    };
    nodev = {
      "/" = {
        fsType = "tmpfs";
        mountOptions = [
          "relatime"
          "nosuid"
          "nodev"
          "size=2G"
          "mode=755"
        ];
      };
    };
  };

  fileSystems."/persist".neededForBoot = true;

  services.scx = {
    enable = config.boot.kernelPackages == inputs'.nyx.packages.linuxPackages_cachyos;
    scheduler = "scx_bpfland";
  };
  boot = {
    loader.efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/efi";
    };

    initrd = {
      systemd = {
        enable = true;
        # emergencyAccess = data.keys.hashedPasswd;
        # work with cachyos kernel
        # suppressedStorePaths = [
        #   "${config.boot.initrd.systemd.package}/lib/systemd/system-generators/systemd-hibernate-resume-generator"
        # ];
      };
      availableKernelModules = [
        "nvme"
        "usbhid"
        "xhci_pci"
        "usb_storage"
        "sd_mod"
      ];
      kernelModules = [ "amdgpu" ];
    };
    kernelModules = [
      "kvm-amd"
      # "dm_sflc"
    ];
    kernelParams = [
      "amd_pstate=active"
      "amd_iommu=on"
      "random.trust_cpu=off"
      "zswap.enabled=1"
      "zswap.compressor=zstd"
      "zswap.zpool=zsmalloc"
      # "ia32_emulation=0"
    ];
    extraModulePackages =
      let
        inherit (config.boot.kernelPackages) v4l2loopback callPackage;
      in
      [
        v4l2loopback
        (callPackage "${self}/pkgs/tcp-brutal.nix" { })
      ];
    kernelPackages =
      # inputs'.nyx.packages.linuxPackages_cachyos;
      pkgs.linuxPackages_latest;
  };

  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp1s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = {
    system = "x86_64-linux";
    # gcc.arch = "znver3";
    # gcc.tune = "znver3";
  };
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  hardware.bluetooth.settings = {
    General = {
      Enable = "Source,Sink,Media,Socket";
    };
  };

  # high-resolution display
  # hardware.video.hidpi.enable = lib.mkDefault true;
}
