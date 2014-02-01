unique template common/ganesha/fsal/gpfs;

variable GANESHA_GPFS_MULTIPLIER ?= 4;

"/software/packages" = pkg_repl("nfs-ganesha-gpfs", GANESHA_VERSION ,"x86_64");

prefix "/software/components/metaconfig/services/{/etc/ganesha/ganesha.nfsd.conf}/contents/main";
"FileSystem/Umask" = '0000';

"CacheInode/Attr_Expiration_Time" = 120;
"CacheInode/Symlink_Expiration_Time" = 120;
"CacheInode/Directory_Expiration_Time"  = 120;

"CacheInode_GC_Policy/Entries_HWMark" = 1500*256*GANESHA_GPFS_MULTIPLIER;
"CacheInode_GC_Policy/Entries_LWMark" = 1000*256*GANESHA_GPFS_MULTIPLIER;
"CacheInode_GC_Policy/LRU_Run_Interval" = 90;
"CacheInode_GC_Policy/FD_HWMark_Percent" = 60;
"CacheInode_GC_Policy/FD_LWMark_Percent" = 20;
"CacheInode_GC_Policy/FD_Limit_Percent" = 90;
"CacheInode_GC_Policy/Reaper_Work" = 15000;

"NFS_Core_Param/Nb_Worker" = 128*GANESHA_GPFS_MULTIPLIER ;
"NFS_Core_Param/MNT_Port" = 32767;
"NFS_Core_Param/NLM_Port" = 32769;
"NFS_Core_Param/RQOTA_Port" = null; # no rqouta on gpfs
"NFS_Core_Param/Nb_Max_Fd" = -1;
"NFS_Core_Param/Clustered" = true;

"SNMP_ADM/export_cache_inode_calls_detail" = null; # not for gpfs

# quirks in packaging nfs-ganesha-gpfs
final variable GANESHA_FSAL_CONFFILE = format('/etc/ganesha/%s.ganesha.nfsd.conf',GANESHA_FSAL);
final variable GANESHA_FSAL_EXPORTFILE = format('/etc/ganesha/%s.ganesha.exports.conf',GANESHA_FSAL);

include { 'components/symlink/config' };
"/software/components/symlink/links" = push(nlist(
    "name", GANESHA_FSAL_CONFFILE,
    "target", GANESHA_CONFFILE,
    "replace", nlist("all","yes"),
    ));
"/software/components/symlink/links" = push(nlist(
    "name", GANESHA_FSAL_EXPORTFILE,
    "target", GANESHA_CONFFILE,
    "replace", nlist("all","yes"),
    ));
