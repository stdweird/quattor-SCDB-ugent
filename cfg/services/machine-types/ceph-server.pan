unique template machine-types/ceph-server;

variable MACHINETYPE_TOP_INSTANCE ?= 'ceph-server';

include 'machine-types/pre/ceph-server';

include 'machine-types/base-vsc';

include { format('site/ceph/%s/config', CEPH_CLUSTER_TEMPLATE) } ;


variable CEPH_MONS_HOSTGROUP ?= 'ceph-mons';
"/system/monitoring/hostgroups" = {
    append("ceph-servers");
    if (index(HOSTNAME, shorten_fqdns(CEPH_MON_HOSTS)) >= 0){
        append(CEPH_MONS_HOSTGROUP);
    };
    SELF;
};

include {
    if(CEPH_MONS_HOSTGROUP == 'ceph-mons-fsload'){
        'site/ceph/monitoring/smart_health';
    };
};
include { 
    if (CEPH_MAJOR_VERSION >= 9) {
        'site/ceph/server/infernalis';
    };
};
include if_exists('site/ceph/cluster/extra_config');
include {if (MACHINETYPE_TOP_INSTANCE == 'ceph-server') {
    'machine-types/post/ceph-server'; # Else this should be included on higer level
    };
};
