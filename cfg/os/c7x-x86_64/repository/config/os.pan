#######################################################################
#
# Standard repositories to use for the OS
#
#######################################################################

unique template repository/config/os;

include { 'quattor/functions/repository' };

# Ordered list of repository to load
# NOTE: The repository which contains the AII rpms must be listed
# first in the list.  If not, then AII installations will fail
# because the post-install script will look in the wrong place.
variable OS_REPOSITORY_LIST = {
    append('quattor');
    append('epel');
    append('c7x_x86_64');
};

