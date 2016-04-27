@{
    Define minimal configuration which is usable for switches, BMC, ...
}
unique template machine-types/minimal;

include 'pan/units';

# Include static information and derived global variables.
variable SITE_DB_TEMPLATE ?= 'site/databases';
include SITE_DB_TEMPLATE;
variable SITE_GLOBAL_VARS_TEMPLATE ?= 'site/global_variables';
include SITE_GLOBAL_VARS_TEMPLATE;
# define site functions
variable SITE_FUNCTIONS_TEMPLATE ?= 'site/functions';
include SITE_FUNCTIONS_TEMPLATE;
# hardware
include 'hardware/functions';
variable HOSTMACHINE ?= {
    if ( is_defined(DB_MACHINE[FULL_HOSTNAME]) ) {
        DB_MACHINE[FULL_HOSTNAME];
    } else {
        ## try HOSTNAME
        if ( is_defined(DB_MACHINE[HOSTNAME]) ) {
            DB_MACHINE[HOSTNAME];
        } else {
            error("/hardware: hardware not found in machine database DB_MACHINE for FULL_HOSTNAME ("+FULL_HOSTNAME+") or HOSTNAME ("+HOSTNAME+")");
        };
    };
};
"/hardware" = create(HOSTMACHINE);

variable MACHINE_PARAMS_CONFIG ?= undef;
include MACHINE_PARAMS_CONFIG;
"/hardware" = {
    if ( exists(MACHINE_PARAMS) && is_nlist(MACHINE_PARAMS) ) {
        update_hw_params();
    };

    SELF;
};


# Networking IP addresses
prefix "/system/network";
"hostname" = HOSTNAME;
"domainname" = DOMAIN;
"nameserver" = NAMESERVERS;
"default_gateway" = GATEWAY;
"interfaces" = copy_network_params_simple(NETWORK_PARAMS);

"/system/aii/dhcp/options" = dict();

include 'site/parenting';
"/system/monitoring/parents" = {
    get_parent()
};
