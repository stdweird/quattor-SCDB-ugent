unique template common/ctdb/ganesha;

final variable GANESHA_MANAGES_GANESHA = false;

variable CTDB_GANESHA_GPFS_GANRECDIR_TARGET_BASEDIR ?= undef;

variable CTDB_GANESHA_GPFS_GANRECDIR_TARGET = format("%s/ganesharecdir", CTDB_GANESHA_GPFS_GANRECDIR_TARGET_BASEDIR);
include 'common/ganesha/service';
prefix "/software/components/metaconfig/services/{/etc/sysconfig/ctdb}/contents/service";
'nfs_server_mode' = 'ganesha';
'nfs_hostname' = FULL_HOSTNAME;
'ctdb_nfs_skip_share_check' = true;
'ctdb_ganesha_rec_link_dst' = CTDB_GANESHA_GPFS_GANRECDIR_TARGET;

# configure /etc/sysconfig/nfs
# needed for statd
include 'components/sysconfig/config';
"/software/components/sysconfig/files/nfs" = dict(
    #'STATD_OUTGOING_PORT','596',
    #'STATD_PORT','595',
    #'STATD_SHARED_DIRECTORY',CTDB_NFS_SHAREDFS_BASEDIR+'/statd',
    'STATD_HOSTNAME',format('"%s -H /etc/ctdb/statd-callout"',FULL_HOSTNAME),
);

include if_exists('common/ctdb/ganesha_'+GANESHA_FSAL);
