unique template common/rsync/config;

## generate config file
variable RSYNC_CONF_LOC ?= "/etc/rsyncd.conf";
variable RSYNC_SECRETS_LOC ?= "/etc/rsyncd.secrets";

include 'metaconfig/rsync/daemon';

prefix "/software/components/metaconfig/services/{/etc/rsyncd.conf}/contents";
"sections/pbsacc" = create("common/rsync/pbsacc");
"sections/pbsmon2php" = create("common/rsync/pbsmon2php");

include 'components/filecopy/config';

"/software/components/filecopy/services/{/etc/rsyncd.secrets}" = dict(
    "config", format("pbsacc:%s\npbsmon2php:%s\n", RSYNC_PBSACC_PWD, RSYNC_PBSMON2PHP_PWD),
    "owner", "root:root",
    "perms", "0400");
