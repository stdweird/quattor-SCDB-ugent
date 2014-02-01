unique template common/rsync/config;

## generate config file
variable RSYNC_CONF_LOC ?= "/etc/rsyncd.conf";
variable RSYNC_SECRETS_LOC ?= "/etc/rsyncd.secrets";

include 'common/rsync/schema';

include 'components/metaconfig/config';
include 'components/filecopy/config';

prefix "/software/components/metaconfig/services/{/etc/rsyncd.conf}";

"module" = "rsync/daemon";

"contents/log" = "/var/log/rsyncd";
"contents/facility" = "daemon";
"contents/sections/pbsacc" = create("common/rsync/pbsacc");
"contents/sections/pbsmon2php" = create("common/rsync/pbsmon2php");

"/software/components/filecopy/services/{/etc/rsyncd.secrets}" = nlist(
    "config", format("pbsacc:%s\npbsmon2php:%s\n", RSYNC_PBSACC_PWD, RSYNC_PBSMON2PHP_PWD),
    "owner", "root:root",
    "perms", "0400");
