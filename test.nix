{
  name = "It is possible to run runqlat tool on a machine";

  nodes = {
    # These configs do not add anything to the default system setup
    machine1 = { pkgs, ... }: { 
      environment.systemPackages = with pkgs; [
        htop
        bcc
        bpftrace
      ];
    };
  };

  # Note that machine1 and machine2 are now available as
  # Python objects and also as hostnames in the virtual network
  testScript = ''
    machine1.wait_for_unit("network-online.target")
    out = machine1.succeed("runqlat 1 1")
    print("Output of runqlat: " + out)
    machine1.succeed("runqlat.bt")
  '';
}
