# Template doing configuration common to Torque client and server,
# mainly pbsknownhosts and ssh config.

unique template common/torque2/config;

variable TORQUE_HOME_SPOOL ?= "/var/spool/pbs";
variable TORQUE_USR_SBIN ?= '/usr/sbin';
variable TORQUE_USR_BIN ?= '/usr/bin';

variable TORQUE_RESTRICT_ACCESS ?= false;
include {if(TORQUE_RESTRICT_ACCESS) {'common/torque2/access'};};

# ----------------------------------------------------------------------------
# etcservices
# ----------------------------------------------------------------------------
include { 'components/etcservices/config' };

"/software/components/etcservices/entries" = {
    append("pbs 15001/tcp");
    append("pbs_mom 15002/tcp");
    append("pbs_resmom 15003/tcp");
    append("pbs_resmom 15003/udp");
    append("pbs_sched 15004/tcp");
};

# ---------------------------------------------------------------------------- 
# pbsclient (masters must be defined on the server too).
# ---------------------------------------------------------------------------- 
include { 'components/pbsclient/config' };
"/software/components/pbsclient/masters" =
    if( is_defined(PBSCLIENT_MASTERS) && is_list(PBSCLIENT_MASTERS) ) {
        PBSCLIENT_MASTERS;
    } else {
        list(CE_SERVER_NAME);
    };
# pbs_mom state is defined in server and client respective config.tpl
"/software/components/chkconfig/service/pbs_mom/startstop" = true;


## for torque v4 and above, use trqauthd
include  {  if (match(TORQUE_RPM_VERSION,'^[4-9]\.')){ 'common/torque2/trqauthd' } };

# ----------------------------------------------------------------------------
# Configure ssh for communication between CE and WNs
# ----------------------------------------------------------------------------
include { 'common/ssh/ce' };


