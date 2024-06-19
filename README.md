### Run a VM

#### Build and run the VM
```bash
nixos-rebuild build-vm --flake .#test
# expose port 22 from guest
export QEMU_NET_OPTS="hostfwd=tcp::2221-:22"
result/bin/run-nixos-vm
```

#### Ssh onto the machine

```bash
ssh -oUserKnownHostsFile=/dev/null -oStrictHostKeyChecking=no admin@localhost -p 2221
```

### Run automated tests

```bash
# non interactive mode
nix build

# after it fails you can obtain logs by running
nix log

# interactive mode
nix run .#default.driverInteractive
```
