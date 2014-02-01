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

unique template machine-types/core;


# Include static information and derived global variables.
variable SITE_DB_TEMPLATE ?= 'site/databases';
include { SITE_DB_TEMPLATE };
variable SITE_GLOBAL_VARS_TEMPLATE ?= 'site/global_variables';
include { SITE_GLOBAL_VARS_TEMPLATE };

#
# define site functions
#
variable SITE_FUNCTIONS_TEMPLATE ?= 'site/functions';
include { SITE_FUNCTIONS_TEMPLATE };

#
# profile_base for profile structure
#
include { 'quattor/profile_base' };

#
# NCM core components
#
include { 'components/spma/config' };
include { 'components/grub/config' };


#
# hardware
#
include { 'hardware/functions' };
variable HOSTMACHINE ?= {
    if ( is_defined(DB_MACHINE[escape(FULL_HOSTNAME)]) ) {
        DB_MACHINE[escape(FULL_HOSTNAME)];
    } else {
        ## try HOSTNAME
        if ( is_defined(DB_MACHINE[escape(HOSTNAME)]) ) {
            DB_MACHINE[escape(HOSTNAME)];
        } else {
            error("/hardware: hardware not found in machine database DB_MACHINE for FULL_HOSTNAME ("+FULL_HOSTNAME+") or HOSTNAME ("+HOSTNAME+")");
        };
    };
};
"/hardware" = create(HOSTMACHINE);

variable MACHINE_PARAMS_CONFIG ?= undef;
include { MACHINE_PARAMS_CONFIG };
"/hardware" = if ( exists(MACHINE_PARAMS) && is_nlist(MACHINE_PARAMS) ) {
                update_hw_params();
              } else {
                SELF;
              };


# Cluster specific configuration
variable CLUSTER_INFO_TEMPLATE ?= 'site/cluster_info';
include { CLUSTER_INFO_TEMPLATE };


# common site machine configuration
variable SITE_CONFIG_TEMPLATE ?= 'site/config';
include { SITE_CONFIG_TEMPLATE };


# File system configuration.
# filesystem/config is new generic approach for configuring file systems : use if it is present. It requires
# a site configuration template passed in FILESYSTEM_LAYOUT_CONFIG_SITE (same name as previous template
# but not the same contents).
variable FILESYSTEM_CONFIG_SITE ?= if_exists("filesystem/config");
variable FILESYSTEM_LAYOUT_CONFIG_SITE ?= "site/filesystems/base";
variable FILESYSTEM_CONFIG_SITE ?= "site/filesystems/base";


# Select OS version based on machine name
include { 'os/version' };


# variable indicating if namespaces must be used to access OS templates.
# always true?
variable OS_TEMPLATE_NAMESPACE = true;

# Define OS related namespaces
variable OS_NS_CONFIG = 'config/';
variable OS_NS_OS = OS_NS_CONFIG + 'os/';
variable OS_NS_CONFIG_BASE = OS_NS_CONFIG + 'core/' ;
variable OS_NS_QUATTOR = OS_NS_CONFIG + 'quattor/';
variable OS_NS_RPMLIST = 'rpms/';
variable OS_NS_REPOSITORY = 'repository/';


#
# software packages
#
include { 'pan/functions' };

#
# Configure Bind resolver
#
variable SITE_NAMED_CONFIG_TEMPLATE ?= 'site/named';
include { SITE_NAMED_CONFIG_TEMPLATE };


#
# Include OS version dependent RPMs
#
include { return(OS_NS_CONFIG_BASE+"base") };


#
# Quattor client software
#
include { 'quattor/client/config' };



# Configure filesystem layout.
# Must be done after NFS initialisation as it may tweak some mount points.
include { return(FILESYSTEM_CONFIG_SITE) };


#
# Site Monitoring
#
variable MONITORING_CONFIG_SITE ?= 'site/monitoring/config';
include { if_exists(MONITORING_CONFIG_SITE) };


#
# AII component must be included after much of the other setup.
#
include { OS_NS_QUATTOR + 'aii' };


#
# Add local users if some configured
#
variable USER_CONFIG_INCLUDE = if ( exists(USER_CONFIG_SITE) && is_defined(USER_CONFIG_SITE) ) {
                                 return('users/config');
                               } else {
                                 return(null);
                               };
include { USER_CONFIG_INCLUDE };


## ntp/ptp settings
include { 'site/time' };

include { 'common/quattorid/service' };

#
# Add site specific configuration if any
#
variable CORE_CONFIG_SITE ?= null;
include { return(CORE_CONFIG_SITE) };

# The template is called by machine-types templates.
variable OS_POSTCONFIG_TYPE ?= 'core';
variable OS_POSTCONFIG ?= 'config/'+OS_POSTCONFIG_TYPE+'/postconfig';

# Default repository configuration template
variable PKG_REPOSITORY_CONFIG ?= 'repository/config';

include { 'site/parenting' };
"/system/monitoring/parents" = {
    get_parent()
};

# run chkconfig post spma
'/software/components/spma/dependencies/post' = append('chkconfig');

variable USE_SERVICE_SANITY ?= true;
include {if(USE_SERVICE_SANITY){'site/service_sanity'}};

variable USE_NAGIOS ?= true;
include { if(USE_NAGIOS) {'common/nagios/service'};};

variable USE_SLOCATE ?= true;
include { if(USE_SLOCATE) {'common/slocate/service'};};

variable USE_COLLECTL ?= true;
variable COLLECTL_DAEMONMETRICS ?= {
    ib='';
    if(exists('/hardware/cards/ib')) {
        ib='X';
    };
    # detailed CPU, memory, disk, network and optional IB stats
    format('-s+CMDN%s', ib);
};
include { if(USE_COLLECTL) {'common/collectl/service'};};
