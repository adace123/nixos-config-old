NixOS config using flakes and home-manager

To test out in a QEMU VM:
1. Download the NixOS [minimal ISO](https://nixos.org/download.html).
2. To start the VM run: 
```bash
sudo virt-install \
  --name nixos \
  --boot uefi \
  --ram 4096 \
  --vcpus 4 \
  --network bridge:virbr0 \
  --os-type linux \
  --os-variant nixos-unstable \
  --disk path=/var/lib/libvirt/images/nixos.qcow2,size=75 \
  --console pty,target_type=serial \
  --cdrom <ISO path>
```
3. Attach a console to the VM using virt-manager. (TODO: Determine how to do this from the CLI)
4. Inside the VM run nix-shell --run "git clone https://github.com/adace123/nixos-config" -p git
5. Run `nix-shell --run "sudo git config --global --add safe.directory /home/nixos/nixos-config" -p git`
6. To format / partition the drives and install NixOS run `nix-shell --run "sudo bash /home/nixos/nixos-config/nixos/install-setup.sh /dev/vda"` -p git nixFlakes
