unique template common/libvirt/qemu-kvm/user;
include 'components/accounts/config';
"/software/components/accounts/groups/kvm" =
  dict("gid", 36);

"/software/components/accounts/groups/qemu" =
  dict("gid", 107);

"/software/components/accounts/users/qemu" = dict(
  "uid", 107,
  "groups", list("kvm"),
  "comment","kvm",
  "shell", "/sbin/nologin",
  "homeDir", "/"
);
