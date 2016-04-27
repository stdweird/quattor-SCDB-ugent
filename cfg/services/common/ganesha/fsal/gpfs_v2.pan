unique template common/ganesha/fsal/gpfs_v2;

variable GANESHA_GPFS_MULTIPLIER ?= 4;

"/software/packages" = { 
    pkg_repl("nfs-ganesha-gpfs", GANESHA_VERSION ,"x86_64");
};

prefix "/software/components/metaconfig/services/{/etc/ganesha/ganesha.conf}/contents/main/CACHEINODE";

"Attr_Expiration_Time" = 600;
"Entries_HWMark" = 1500*256*GANESHA_GPFS_MULTIPLIER;
"LRU_Run_Interval" = 90;
"FD_HWMark_Percent" = 60;
"FD_LWMark_Percent" = 20;
"FD_Limit_Percent" = 90;

prefix "/software/components/metaconfig/services/{/etc/ganesha/ganesha.conf}/contents/main/NFS_CORE_PARAM";
"Nb_Worker" = 128*GANESHA_GPFS_MULTIPLIER ;
"Clustered" = true;
"NFS_Protocols" = list(3,4);
"NFS_Port" = 2049;
"MNT_Port" = 32767;
"NLM_Port" = 32768;
"Rquota_Port" = 32769;
"RPC_Max_Connections" = 10000;
"heartbeat_freq" = 0;
#"Short_File_Handle" = true;

prefix "/software/components/metaconfig/services/{/etc/ganesha/ganesha.conf}/contents/main/NFSV4";
"Delegations" = false;
"Lease_Lifetime" = 60;

prefix "/software/components/metaconfig/services/{/etc/ganesha/ganesha.conf}/contents/main/GPFS";
"Delegations" = "read";
"fsal_trace" = true;
"fsal_grace" = true;

prefix "/software/components/metaconfig/services/{/etc/ganesha/ganesha.conf}/contents/main/EXPORT_DEFAULTS";
"Access_Type" = "None";
"Protocols" = list('4');
"Transports" = list('TCP');
"Anonymous_uid" = -2;
"Anonymous_gid" = -2;
"SecType" = list("sys");
"PrivilegedPort" = false;
"Manage_Gids" = true; # More than 16 groups
"Squash" = "root_squash";
"NFS_Commit" = false;
#"Disable_ACL" = false; #default

variable GANESHA_FSAL_GPFS_BLOCK ?= dict("name", "GPFS");
variable GANESHA_EXPORT_DEFAULT_CLIENT ?= dict("Access_Type" , "RW", "Clients" , list("*.vsc"));
