#######################################################################
#
# Standard repositories to use for the OS
#
#######################################################################

unique template repository/config/site;


variable OS_REPOSITORY_LIST = {
    append('pub');
    append('homemade');
    append('homemade-priv');
    append('private');
    SELF;
};
