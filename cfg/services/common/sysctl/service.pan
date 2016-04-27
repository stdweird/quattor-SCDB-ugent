unique template common/sysctl/service;

# List of additonal structure templates to load
variable SYSCTL_EXTRA_CONFIGS ?= list();

variable SYSCTL_SHM_MULTIPLIER ?= 1;

include 'common/sysctl/config';
