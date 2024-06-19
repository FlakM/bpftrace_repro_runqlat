{ lib, pkgs, ... }: {
  users.groups.admin = {};
  users.users = {
    admin = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      password = "admin";
      group = "admin";
    };
  };

  virtualisation.vmVariant = {
    virtualisation = {
      memorySize = 2048;
      cores = 3;
      graphics = false;
    };
  };

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = true;
  };

  networking.firewall.allowedTCPPorts = [ 22 ];
  environment.systemPackages = with pkgs; [
    htop
    bcc
    bpftrace
    strace
    eza
  ];

  # Allow admin to use sudo without password
  security.sudo.extraRules = [
    { users = ["admin"]; commands = [{ command = "ALL"; options = ["NOPASSWD"]; }]; }
  ];

  system.stateVersion = "23.05";
}
