unique template machine-types/ceph-one-hyp;

variable MACHINETYPE_TOP_INSTANCE ?= 'ceph-one-hyp';

include 'machine-types/pre/ceph-one-hyp';

include 'machine-types/ceph-server';
include 'machine-types/one-hypervisor';

include {if (MACHINETYPE_TOP_INSTANCE == 'ceph-one-hyp') {
    'machine-types/post/ceph-one-hyp'; # Else this should be included on higer level
    };
};
