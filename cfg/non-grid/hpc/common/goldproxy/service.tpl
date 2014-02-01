unique template common/goldproxy/service;

include { 'common/goldproxy/rpms/config'+RPM_BASE_FLAVOUR };

include { 'common/goldproxy/config' };

variable ORIG_MOAB_GOLD_SERVER ?= {
    if (is_defined(MOAB_GOLD_SERVER)) {
        return(MOAB_GOLD_SERVER)
    } else {
        return(undef);
    };
};

variable MOAB_GOLD_SERVER = "localhost:7113";
