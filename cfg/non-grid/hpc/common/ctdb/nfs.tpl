unique template common/ctdb/nfs;

variable CTDB_NFS_SHAREDFS_BASEDIR ?= CTDB_SHAREDFS_BASEDIR;

variable CTDB_NFS_HOSTNAME ?= undef;
## still no v4 support
variable CTDB_NFS_VERS ?= '-N 4';

## disable nfs
"/software/components/chkconfig/service/nfs/off" = "";
"/software/components/chkconfig/service/nfslock/off" = "";
## NFS control is for ctdb
"/software/components/chkconfig/service/nfs/startstop" = false;
"/software/components/chkconfig/service/nfslock/startstop" = false;

## configure /etc/sysconfig/nfs
include {'components/sysconfig/config'};
"/software/components/sysconfig/files/nfs" = nlist(
    'CTDB_MANAGES_NFS','yes',
    'LOCKD_TCPPORT','599',
    'LOCKD_UDPPORT','599',
    'MOUNTD_PORT','597',
    'NFS_HOSTNAME','"'+CTDB_NFS_HOSTNAME+'"',
    'NFS_TICKLE_SHARED_DIRECTORY',CTDB_NFS_SHAREDFS_BASEDIR+'/tickles',
    'RPCNFSDARGS','"'+CTDB_NFS_VERS+' 32"',
    'RQUOTAD_PORT','598',
    'STATD_OUTGOING_PORT','596',
    'STATD_PORT','595',
    'STATD_SHARED_DIRECTORY',CTDB_NFS_SHAREDFS_BASEDIR+'/statd',
    'STATD_HOSTNAME','"'+CTDB_NFS_HOSTNAME+' -H /etc/ctdb/statd-callout -p 97"',
);

variable CTDB_NFS_EXPORTS ?= nlist();
## nfs exports will be reset
include {'components/nfs/config'};
"/software/components/nfs" = {
    ## reset exports
    SELF['exports'] = list();
    foreach(epath;acl;CTDB_NFS_EXPORTS) {
        SELF['exports'][length(SELF['exports'])] = nlist("path",unescape(epath),
                                                         "hosts",acl);
    };
    SELF;
};    