unique template common/zookeeper/config;

variable ZOOKEEPER_DATADIR ?= "/var/lib/zookeeper";

final variable MYID = {
    foreach (idx;hn;ZOOKEEPER_SERVERS) {
        if(match(FULL_HOSTNAME,format("^%s$",hn))) {
            return(idx);
        };
    };
    error(format("No match in ZOOKEEPER_SERVERS list %s",to_string(ZOOKEEPER_SERVERS)));
};   

prefix '/software/components/accounts';
'kept_users/zookeeper' = '';
'kept_groups/zookeeper' = '';
include 'components/dirperm/config';
"/software/components/dirperm/paths" = append(dict(
    "path",    ZOOKEEPER_DATADIR,
    "owner",   "zookeeper:zookeeper",
    "perm",    "0755",
    "type",    "d",
    ));
"/software/components/dirperm/paths" = append(dict(
    "path",    format("%s/version-2", ZOOKEEPER_DATADIR),
    "owner",   "zookeeper:zookeeper",
    "perm",    "0755",
    "type",    "d",
    ));

'/software/components/filecopy/services' =
  npush(escape(format("%s/myid", ZOOKEEPER_DATADIR)),
        dict('config', format("%s\n",MYID),
              'owner','zookeeper:zookeeper',
              'perms', '0644',
              ));

# set java options
'/software/components/filecopy/services' =
  npush(escape("/etc/zookeeper/conf/java.env"),
        dict('config', "export _JAVA_OPTIONS='-Xmx256M -Xms256M'\n",
              'owner','zookeeper:zookeeper',
              'perms', '0644',
              ));

# set server config
include 'metaconfig/zookeeper/config';

prefix "/software/components/metaconfig/services/{/etc/zookeeper/conf/zoo.cfg}/contents";
"main/dataDir" = ZOOKEEPER_DATADIR;
"servers" = {
    foreach(idx;hn;ZOOKEEPER_SERVERS) {
        append(dict("hostname", hn));
    };
    SELF;
};
