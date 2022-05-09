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
4. Inside the VM run nix-shell -I https://github.com/NixOs/nixpkgs-channels/archive/nixos-unstable.tar.gz --run "git clone https://github.com/adace123/nixos-config && sudo bash ./nixos-config/nixos/setup.sh /dev/vda" -p git nixFlakes home-manager
