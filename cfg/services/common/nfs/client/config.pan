unique template common/nfs/client/config;

variable NFS_CLIENT_TEMPLATE = if ( exists(NFS_AUTOFS) && is_defined(NFS_AUTOFS) && NFS_AUTOFS ) {
                                 return("common/nfs/client/autofs");
                               } else {
                                 return("common/nfs/client/fstab");
                               };
include NFS_CLIENT_TEMPLATE;
