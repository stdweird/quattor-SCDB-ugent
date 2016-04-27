unique template common/gpfs/service;

variable GPFS_NSD_REGEX ?= 'wont match';
variable GPFS_IS_NSD ?= match(FULL_HOSTNAME,GPFS_NSD_REGEX);

variable GPFS_MANAGER_REGEX ?= 'wont match';
variable GPFS_IS_MANAGER ?= match(FULL_HOSTNAME,GPFS_MANAGER_REGEX);
include "common/gpfs/config";
## start gpfs service
"/software/components/chkconfig/service/gpfs" = dict("on", "", "startstop", true);

## add filesystems to fstab?

"/system/monitoring/hostgroups" = {
    append(SELF,"gpfs_servers");
    SELF;
};

# logstash only on nsds
variable GPFS_FILEBEAT ?= true;

include { 
    if(GPFS_FILEBEAT) {
        'common/gpfs/filebeat';
    } else {
        'common/gpfs/logstash';
    };
};
