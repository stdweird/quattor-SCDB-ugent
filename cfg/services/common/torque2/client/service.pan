unique template common/torque2/client/service;

# Add RPMs
# no +RPM_BASE_FLAVOUR
include 'common/torque2/client/packages';
# Configure Torque client
include 'common/torque2/client/config';
# Force a service restart if specified.
# This is done by checking if a restart timestamp is defined. In fact this can
# be an arbirtrary number and a restart is done if it is changed. It is recommended
# to use a timestamp for better tracking, something like 20060724-12:50.
include 'components/filecopy/config';
variable TORQUE_CLIENT_RESTART_FILE = "/var/quattor/restart/pbs_mom";
variable TORQUE_CLIENT_RESTART_CMD = "/sbin/service pbs_mom restart";
"/software/components/filecopy/services" =
{
  services = SELF;
  restart_time = undef;
  if ( exists(LRMS_CLIENT_RESTART[FULL_HOSTNAME]) &&
       is_defined(LRMS_CLIENT_RESTART[FULL_HOSTNAME]) ) {
    restart_time = LRMS_CLIENT_RESTART[FULL_HOSTNAME];
  };
  if ( !is_defined(restart_time) &&
       exists(LRMS_CLIENT_RESTART['DEFAULT']) &&
       is_defined(LRMS_CLIENT_RESTART['DEFAULT']) ) {
    restart_time = LRMS_CLIENT_RESTART['DEFAULT'];
  };
  if ( is_defined(restart_time) ) {
    services[escape(TORQUE_CLIENT_RESTART_FILE)] = dict("config",restart_time,
                                                         "owner","root",
                                                         "perms","0644",
                                                         "restart",TORQUE_CLIENT_RESTART_CMD);
  };
  services;
};

## client BLCR settings
variable TORQUE_USE_BLCR ?= false;
include { if(TORQUE_USE_BLCR) {"common/blcr/service"} };
