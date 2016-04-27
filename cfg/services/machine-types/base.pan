unique template machine-types/base;

include 'machine-types/core';

# include hpc specifics
variable BASE_SITE_HPC ?= null;
include BASE_SITE_HPC;
# set remaining defaults
variable BASE_DEFAULTS ?= 'defaults/config';
include BASE_DEFAULTS;
variable USE_OFED ?= false;
include {if (USE_OFED) { 'common/ofed/service' } };

# no post/core, there's post/base
