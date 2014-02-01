unique template common/perfctr/packages;


prefix '/software/packages';

"{perfctr}" = nlist();

variable PERFCTR_INCL_TOOLS ?= true;

include {
    if (PERFCTR_INCL_TOOLS) {
	return('common/perfctr/rpms/tools');
    } else {
	null;
    };
};
