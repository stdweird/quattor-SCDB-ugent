unique template common/ctdb/ganesha;

final variable CTDB_MANAGES_GANESHA = true;
include {'common/ganesha/service'};

"/software/components/sysconfig/files/ctdb" = {
    SELF['NFS_SERVER_MODE']='ganesha';
    SELF['NFS_HOSTNAME']=FULL_HOSTNAME;
    SELF['CTDB_NFS_SKIP_SHARE_CHECK']=booltoyesno(true);
    SELF;
};

# configure /etc/sysconfig/nfs
# needed for statd
include {'components/sysconfig/config'};
"/software/components/sysconfig/files/nfs" = nlist(
    #'STATD_OUTGOING_PORT','596',
    #'STATD_PORT','595',
    #'STATD_SHARED_DIRECTORY',CTDB_NFS_SHAREDFS_BASEDIR+'/statd',
    'STATD_HOSTNAME',format('"%s -H /etc/ctdb/statd-callout"',FULL_HOSTNAME),
);

include if_exists('common/ctdb/ganesha_'+GANESHA_FSAL);
