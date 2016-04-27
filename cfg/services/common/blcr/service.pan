unique template common/blcr/service;

variable USE_BLCR = true;

include 'common/blcr/rpms/config';

include 'common/blcr/config';

variable BLCR_CLIENT_FLAVOUR ?= "torque";

include { if(is_defined(BLCR_CLIENT_FLAVOUR)) {format("common/blcr/%s",BLCR_CLIENT_FLAVOUR)}};

# disable random prelinking
include 'common/prelink/service';

# nscd: no shared variables
variable USE_NSCD ?= false;
include { if(USE_NSCD) {'common/nscd/service'}};
