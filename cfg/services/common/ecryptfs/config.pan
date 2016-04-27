unique template common/ecryptfs/config;

include 'components/accounts/config';

prefix '/software/components/accounts';

"groups/ecryptfs" = dict("gid", 480);
'kept_groups/ecryptfs' = ''; 

prefix '/software/packages';
"ecryptfs-utils" = dict();

prefix "/software/components/dirperm";
"paths" = append(dict(
    "path", "/sbin/mount.ecryptfs_private",
    "owner", "root:ecryptfs",
    "perm", "4750",
    "type", "f" 
));
