{ config, pkgs, ...}:

{
  imports = [
    (import ./compton.nix {inherit config pkgs; })
  ];
  
  services = {
    xserver = {
      enable = true;
      layout = "us";

      libinput = {
        enable = true;
      };

      displayManager.sddm.enable = true;

      windowManager = {
        i3.enable = true;
        default = "i3";
      };
    };

    printing = {
       enable = true;
       drivers = (with pkgs; [ gutenprint splix ]);
     };

    acpid.enable = true;
    emacs.enable = true;
    # todo : look into conf of ssh.
    #openssh.enable = true;
  };
  
  
}
