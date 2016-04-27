unique template common/libvirt/qemu-kvm/wipe_autostart_default_network;

# wipe default qemu autostart network (for now) 
# by default, it's a symlink to /etc/libvirt/qemu/networks/default.xml
# replace it with empty file (it will keep the source default.xml)
prefix "/software/components/filecopy/services/{/etc/libvirt/qemu/networks/autostart/default.xml}";
"config" = '';
"perms" = "0644";
"owner" = "root";
"group" = "root";
"restart" = "service libvirtd restart";
"backup" = false;
