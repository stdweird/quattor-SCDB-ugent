# Template to configure ssh and sshd on CE and WNs

unique template common/ssh/ce;


# ----------------------------------------------------------------------------
# Control variables initialization
# -----------------------------------------------------------------------------

# If CE_USE_SSH is undef, check NFS configuration to determine
# if it is required
variable SSH_HOSTBASED_AUTH ?=
    if ( !exists(CE_USE_SSH) || !is_defined(CE_USE_SSH) ) {
        if ( exists(CE_SHARED_HOMES) && is_defined(CE_SHARED_HOMES) && CE_SHARED_HOMES ) {
            return(false);
        } else {
            return(true);
        };
    } else {
        return(CE_USE_SSH);
    };

# Configure also RSH hosts.equiv. Default : false.
# 3 possible values :
#    - true : create hosts.equiv with CE and WNs
#    - false : create an empty hosts.equiv (disable an existing configuration)
#    - undef : don't do anything (keep an existing hosts.equiv)
# There is normally no need to create hosts.equiv.
variable VAR_EXISTS = exists(RSH_HOSTS_EQUIV);
variable RSH_HOSTS_EQUIV ?= if (VAR_EXISTS) {
                                return(RSH_HOSTS_EQUIV);
                            } else {
                                return(false);
                            };

#If true allow hostauthentification for localhost only
variable SSH_HOSTBASED_AUTH_LOCAL ?= false;

# Used to set the value of SSH configuration options in SSH configuration files
variable SSH_HOSTBASED_CONFIG =
    if ( SSH_HOSTBASED_AUTH ) {
        return("yes");
    } else {
        return("no");
    };

# Build list of WNs + CE + TORQUE_SERVER_CLIENTS to be used to produce hosts.equiv and shosts.equiv.
# Set it to an empty list if SSH_HOSTBASED_CONFIG is false.

variable CE_HOST_LIST = {
    value = CE_HOST + "\n";
    if (exists(CE_PRIV_HOST) && is_defined(CE_PRIV_HOST)) {
		value = value + CE_PRIV_HOST + "\n";
    };
    if (exists(WORKER_NODES) && is_defined(WORKER_NODES)) {
        foreach(idx;v;WORKER_NODES) {
            value = value + v + "\n";
        };
    };
    if (exists(TORQUE_SERVER_CLIENTS) && is_defined(TORQUE_SERVER_CLIENTS)) {
        foreach(idx;v;TORQUE_SERVER_CLIENTS) {
            value = value + v + "\n";
        };
    };
    value;
};

variable SHOSTS_EQUIV_LIST = {
    if ( SSH_HOSTBASED_AUTH ) {
        return(CE_HOST_LIST);
    } else if ( SSH_HOSTBASED_AUTH_LOCAL ) {
        #return(FULL_HOSTNAME +  "\n" + CE_HOST);
        return(FULL_HOSTNAME);
    } else {
        return("");
    };
};

variable HOSTS_EQUIV_LIST ?= {
    if ( is_defined(RSH_HOSTS_EQUIV) && RSH_HOSTS_EQUIV ) {
        return(CE_HOST_LIST);
    } else {
        return("");
    };
};

# ----------------------------------------------------------------------------
# pbsknownhosts
# -----------------------------------------------------------------------------
variable USE_PBS_KNOWNHOSTS ?= false;
include { if(USE_PBS_KNOWNHOSTS) { 'common/ssh/pbsknownhosts' } };

# ----------------------------------------------------------------------------
# Build SSH client configuration
# ----------------------------------------------------------------------------
include { 'components/filecopy/config' };

variable SSH_HOSTBASED_CONFIG = {
    if ((SSH_HOSTBASED_AUTH) || (SSH_HOSTBASED_AUTH_LOCAL)) {
        return("yes");
    } else {
        return("no");
    };
};


# ----------------------------------------------------------------------------
# Build SSH server configuration
# ----------------------------------------------------------------------------
include { 'components/filecopy/config' };
include { 'components/ssh/config' };

# Configure ssh for host-based authentication.
"/software/components/ssh/daemon/options" = npush(
    'IgnoreUserKnownHosts', 'yes',
    'HostbasedAuthentication', SSH_HOSTBASED_CONFIG,
    'IgnoreRhosts', 'yes',
    'RhostsRSAAuthentication', 'no',
    #'KeepAlive', 'yes',
);

"/software/components/ssh/client/options" = npush(
    "Protocol","2,1",
    "RhostsAuthentication","yes",
    "EnableSSHKeysign","yes",
    "HostbasedAuthentication",SSH_HOSTBASED_CONFIG
);


# Create shosts.equiv file.
'/software/components/filecopy/services' = npush(
    escape('/etc/ssh/shosts.equiv'),
    nlist('config', SHOSTS_EQUIV_LIST,
          'owner', 'root:root',
          'perms', '0644',
         ),
);


# ----------------------------------------------------------------------------
# Create RSH hosts.equiv if requested
# ----------------------------------------------------------------------------

'/software/components/filecopy/services' =
  if ( is_defined(RSH_HOSTS_EQUIV) ) {
    npush(escape('/etc/hosts.equiv'),
      nlist('config', HOSTS_EQUIV_LIST,
            'owner', 'root:root',
            'perms', '0644',
           ),
         );
  } else {
    return(SELF);
  };


# ----------------------------------------------------------------------------
# altlogrotate
# ----------------------------------------------------------------------------
include { 'components/altlogrotate/config' };

"/software/components/altlogrotate/entries/edg-pbs-knownhosts" =
  nlist("pattern", "/var/log/edg-pbs-knownhosts.ncm-cron.log",
        "compress", true,
        "missingok", true,
        "frequency", "weekly",
        "create", true,
        "ifempty", true,
        "rotate", 1);
