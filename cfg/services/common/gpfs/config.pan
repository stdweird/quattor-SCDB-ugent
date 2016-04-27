unique template common/gpfs/config;

final variable GPFS_VERSION_MAJOR = {
    versions=matches(GPFS_VERSION_MAIN, '^(\d+)\.(\d+)\.(\d+)');
    return(to_long(versions[1]));
};

final variable GPFS_VERSION_MINOR = {
    versions=matches(GPFS_VERSION_MAIN, '^(\d+)\.(\d+)\.(\d+)');
    return(to_long(versions[2]));
};

final variable GPFS_VERSION_SUBMINOR = {
    versions=matches(GPFS_VERSION_MAIN, '^(\d+)\.(\d+)\.(\d+)');
    return(to_long(versions[3]));
};

variable GPFS_HADOOP_CONNECTOR ?= { return(GPFS_VERSION_MAJOR >= 4); };

include 'components/gpfs/config';

include 'common/gpfs/rpms/config';

include { if(GPFS_HADOOP_CONNECTOR) {'common/gpfs/hadoop'}; };


## url to mmsdrfs file (or equivalent)
## mandatory url, try to keep it up-to-date as possible
## only used on first install
variable GPFS_CFG_URL ?= undef;
"/software/components/gpfs/cfg/url" = GPFS_CFG_URL;

variable GPFS_CFG_SUBNET ?= DOMAIN;
"/software/components/gpfs/cfg/subnet" = GPFS_CFG_SUBNET;

variable GPFS_CFG_USE_CURL ?= true;
"/software/components/gpfs/cfg/usecurl" = GPFS_CFG_USE_CURL;

variable GPFS_CFG_USE_CCMCERTWITHCURL ?= false;
"/software/components/gpfs/cfg/useccmcertwithcurl" = GPFS_CFG_USE_CCMCERTWITHCURL;

variable GPFS_CFG_USE_SINDESGETCERTCERTWITHCURL ?= true;
"/software/components/gpfs/cfg/usesindesgetcertcertwithcurl" = GPFS_CFG_USE_SINDESGETCERTCERTWITHCURL;

variable GPFS_USE_SNMP ?= GPFS_IS_MANAGER;
include {if(GPFS_USE_SNMP) {'common/gpfs/snmp'};};

variable SSH_CLIENT_CONFIG = "/root/.ssh/config";
variable CONTENT = "StrictHostKeyChecking no\n";

'/software/components/filecopy/services' =
  npush(escape(SSH_CLIENT_CONFIG),
        dict('config',CONTENT,
              'owner','root:root',
              'perms', '0700'));

# list with ssh pub keys
variable GPFS_SSH_ADMIN_PUBKEYS ?= list();
"/software/components/useraccess/users/root/ssh_keys" = {
    foreach(idx;pubkey;GPFS_SSH_ADMIN_PUBKEYS) {
        append(pubkey);
    };
    SELF;
};

# for mmauth/AUTHONLY, add symlink, libssl.so is part of openssl-devel
"/software/components/symlink/links" = {
    append(dict(
        "name", "/usr/lib64/libssl.so.4",
        "target", "/usr/lib64/libssl.so",
        "exists", false,
        "replace", dict("all","yes"),
    ));
    # possibly: libcrypto /usr/lib64/libcrypto.so -> libcrypto.so.1.0.0
    # now by openssl-devel rpm
};

# add mm tools to path
variable GPFS_MM_TOOLS_IN_PATH ?= GPFS_IS_MANAGER;
include 'components/profile/config';
"/software/components/profile" = {
    if (GPFS_MM_TOOLS_IN_PATH) {
        if ( !exists(SELF['path']) || !is_defined(SELF['path']) ) {
            SELF['path'] = dict();
        };
        if ( !exists(SELF['path']['PATH']) || !is_defined(SELF['path']['PATH']) ) {
            SELF['path']['PATH'] = dict();
        };
        if ( !exists(SELF['path']['PATH']['append']) || !is_defined(SELF['path']['PATH']['append']) ) {
            SELF['path']['PATH']['append'] = list();
        };

        SELF['path']['PATH']['append']=append(SELF['path']['PATH']['append'],"/usr/lpp/mmfs/bin");
    };
    SELF;
};

# add mmsdrfs backup script
variable MMSDRFS_BACKUP = "/var/mmfs/etc/mmsdrbackup";
variable CONTENT = <<EOF;
#!/bin/ksh
version=$1  # version number of file /var/mmfs/gen/mmsdrfs
suffix="$version.$(date +%Y.%m.%d.%H.%M.%S).$(hostname -s)"

mkdir -p /var/mmfs/gen/backup
cp  /var/mmfs/gen/mmsdrfs /var/mmfs/gen/backup/mmsdrfs.$suffix

return 0

EOF

'/software/components/filecopy/services' =
  npush(escape(MMSDRFS_BACKUP),
        dict('config',CONTENT,
              'owner','root:root',
              'perms', '0700'));

'/system/licenses' = append(dict(
            "vendor", "IBM",
            "name", "GPFS",
            "enddate", GPFS_SUPPORT_ENDDATE
            ));

# Include sudo rule for nagios checks
include 'common/sudo/config';
"/software/components/sudo/privilege_lines" = append(dict(
    "user", value("/software/components/nrpe/options/nrpe_user"),
    "run_as", "ALL",
    "host", "ALL",
    "cmd", "/usr/lpp/mmfs/bin/mmgetstate",
    "options", "NOPASSWD:"
));
