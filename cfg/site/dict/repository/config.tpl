######################################################################
#
# Standard repositories to use
#
# RESPONSIBLE: Charles Loomis
#
#######################################################################

template repository/config;


include { 'pan/functions' };

# NOTE: This template should be the LAST thing included in a
# machine profile.  If you include packages after this template
# then they will not be "resolved" and SPMA will not function
# correctly.

# Repositories related to base OS and quattor client (should be first)
include {  "repository/config/os"; };

# Repositories related to Lemon (must be included before LCG/Glite)
#include { "repository/config/lemon" };

variable REPOSITORY_CONFIG_PRE ?= undef;
variable REPOSITORY_CONFIG_POST ?= undef;

include { REPOSITORY_CONFIG_PRE };
include { "repository/config/site" };
"/software/repositories" = add_repositories(OS_REPOSITORY_LIST);
include { REPOSITORY_CONFIG_POST };

#
# Standard stuff: resolve repository and purge not used entries
#
include { 'quattor/repository_cleanup' };
