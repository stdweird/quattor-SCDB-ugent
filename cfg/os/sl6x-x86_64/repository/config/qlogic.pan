#######################################################################
#
# Standard repositories to use for the OS
#
#######################################################################

unique template repository/config/qlogic;

include { 'quattor/functions/repository' };

variable OS_REPOSITORY_LIST = append('site_dict_el6_x86_64_qlogic');
