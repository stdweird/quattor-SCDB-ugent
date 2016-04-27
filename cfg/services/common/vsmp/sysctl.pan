unique template common/vsmp/sysctl;

include 'common/sysctl/service';

prefix "/software/components/metaconfig/services/{/etc/sysctl.conf}/contents";

"fs.dir-notify-enable" = "0";
    
# shm-setting
"kernel.shmall" = "9999999999999999";
"kernel.shmmax" = "9999999999999999";
"kernel.shmmni" = "9999999999999999";
    
# overcommit
"vm.overcommit_memory" = "2"; 
"vm.overcommit_ratio" = "97";
