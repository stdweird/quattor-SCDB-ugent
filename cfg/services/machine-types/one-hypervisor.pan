unique template machine-types/one-hypervisor;

variable MACHINETYPE_TOP_INSTANCE ?= 'one-hypervisor';

include 'machine-types/pre/one-hypervisor';

include {if(VSC_NETWORK) 'machine-types/base-vsc' else 'machine-types/base'};

include 'site/one/common';

include 'common/opennebula/node';

# Hyp KVM monitoring
"/system/monitoring/hostgroups" = append("one_hyp_kvm");

include {if (MACHINETYPE_TOP_INSTANCE == 'one-hypervisor') {
    'machine-types/post/one-hypervisor'; # Else this should be included on higer level
    };
};
