unique template site/ceph/cluster/tuning_mds;

prefix "/software/packages";
"hwloc" = dict();
prefix "/software/components/systemd/unit/{ceph-mds@}";
"file/replace" = false; # this is the unit file of the service
"file/only" = true; 
"file/config" = dict();
prefix "/software/components/systemd/unit/{ceph-mds@}/file/custom";

'CPUAffinity' = list('node:1');

prefix "/software/components/systemd/unit/{ceph-mds@}/file/config/service";
'CPUAffinity' = list(list());
