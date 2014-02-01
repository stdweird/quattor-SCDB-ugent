unique template common/sysctl/service;

include {'components/sysctl/config'};

variable SYSCTL_CONFIG ?= "common/sysctl/old_config";
include {SYSCTL_CONFIG};

