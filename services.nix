{ config, pkgs, ...}:

{
  nixpkgs.config.allowUnfree = true;
  imports = [
    (import ./compton.nix {inherit config pkgs; })
  ];
  
  services = {
    xserver = {
      enable = true;
      layout = "us,de";

      libinput = {
        enable = true;
      };

      displayManager.lightdm.enable = true;

      windowManager = {
        i3.enable = true;
        default = "i3";
      };
    };

    avahi = {
        enable = true;
        nssmdns = true;
    };

    printing = {
       enable = true;
       drivers = (with pkgs; [ gutenprint splix ]);
    };
    
    acpid.enable = true;
    emacs.enable = true;
    
    #openssh.enable = true;
  };

  systemd.user.services."udiskie" = {
      enable = true;
      description = "udiskie to automount removable media";
      wantedBy = [ "default.target" ];
      path = with pkgs; [
        gnome3.defaultIconTheme
        gnome3.gnome_themes_standard
        pythonPackages.udiskie
      ];
      environment.XDG_DATA_DIRS="${pkgs.gnome3.defaultIconTheme}/share:${pkgs.gnome3.gnome_themes_standard}/share";
      serviceConfig.Restart = "always";
      serviceConfig.RestartSec = 2;
      serviceConfig.ExecStart = "${pkgs.python27Packages.udiskie}/bin/udiskie -a -t -n -F ";
    };
}
