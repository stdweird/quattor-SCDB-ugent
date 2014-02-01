
template machine-types/perfsonar;


variable OS_NS_CONFIG ?= 'config/perfsonar/';
include { 'machine-types/core' };

include { 'common/nagios/service'};
	# Add perfSONAR configuration
include { 'common/perfsonar/config' };


	# Add internet2 package repository
include { 'repository/config/perfsonar' };
