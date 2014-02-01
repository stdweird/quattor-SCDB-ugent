unique template common/virtualbox/service;

include { 'common/virtualbox/packages' };

include { 'common/virtualbox/config' };

## create vboxusers group
"/software/components/accounts/groups/vboxusers" =
  nlist("gid", 120);
