{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    (import ./packages.nix {inherit config pkgs; })
    (import ./services.nix {inherit config pkgs; })
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable BCACHEFS
  boot.supportedFilesystems = [ "bcachefs" ];	

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Networking
  networking.networkmanager.enable = true;
   
  # Fish
  programs.fish.enable = true;

  # Users
  users.mutableUsers = false;
  users.extraUsers.hiro = {
    isNormalUser = true;
    home = "/home/hiro";
    shell = pkgs.fish;
    extraGroups = ["networkmanager" "wheel" "audio"];
    hashedPassword = "$6$WDVgnDUHXXHm$JGkoT5VU7GAxd9Z34N1bfGF79rnB.P2t.DdSpJ.a3bwipfFFsGD2z13yRKmp3H4PuBdcY.B1i7cyGmEyv3Q.r/";
  };

  # Getting OOMOX to work
  environment.extraInit = ''
    # SVG loader for pixbuf (needed for GTK svg icon themes)
    export GDK_PIXBUF_MODULE_FILE=$(echo ${pkgs.librsvg.out}/lib/gdk-pixbuf-2.0/*/loaders.cache)
  '';

  # No Sudo Password
  security.sudo.wheelNeedsPassword = false;

  # Audio
  hardware.pulseaudio.enable = true;

  # Microcode
  hardware.cpu.intel.updateMicrocode = true;
  
  # Garbage Collector
  nix.gc.automatic = true;
  nix.gc.dates = "weekly";
  nix.gc.options = "--delete-older-than 30d";

  # Power Management
  powerManagement.enable = true;
  powerManagement.powertop.enable = true;
  powerManagement.scsiLinkPolicy = "min_power";

  # Auto Upgrades
  system.autoUpgrade.enable = true;
  system.autoUpgrade.channel = https://nixos.org/channels/nixos-unstable;
}
