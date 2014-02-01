############################################################
#
# template machine-types/core
#
# Define base configuration of any type of node.
# Can be included several times.
#
# SDW: Based on QWG gLite templates, stripped from all legacy and glite stuff 
#
# RESPONSIBLE: SDW
#
############################################################

unique template machine-types/test;


include {'machine-types/core'};

include { 'common/stress/config' };