unique template common/ofed/ipoib;

# add configured network device files using ncm-network
# this should be sufficient
"/software/components/ofed/openib/modules/ipoib" = true;

variable OFED_IPOIB_CONFIG ?= true;
variable OFED_IPOIB_TUNING ?= true;

include { if (OFED_IPOIB_CONFIG) {'common/ofed/ipoib_config'} };
include { if (OFED_IPOIB_TUNING) {'common/ofed/ipoib_tuning'} };
