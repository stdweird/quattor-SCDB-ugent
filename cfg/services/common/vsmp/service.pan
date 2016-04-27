unique template common/vsmp/service;

## 
## preservice needs to be included before this one
##


include { 
    if(is_defined(VSMP_PRESERVICE) && VSMP_PRESERVICE) { 
        'common/vsmp/rpms/config'
    } else { 
        error('vsmp preservice needs to be included before vsmp service');
    };
};
include 'common/vsmp/config';
## 2 scripts, accessed through rc.local
'/software/components/filecopy/services' = copy_file("/usr/bin/scalemp_makesftraid.sh","common/vsmp/files/makestripelvm.sh",0);
'/software/components/filecopy/services' = copy_file("/usr/bin/scalemp_tunedisks.sh","common/vsmp/files/tunedisks.sh",0);
