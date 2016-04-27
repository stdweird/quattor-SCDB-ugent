
# MAUI configuration

unique template common/maui/server/config;

# Variable defining default MAUI configuration
#
# Definition of scheduling interval. This is done with 2 parameters.
# JOBAGGREGATIONTIME defines the time to wait after receiving a job
# event from Torque before begining a scheduling cycle. This allows to
# wait for several job events in this interval that will be processed in
# 1 pass resulting in better MAUI efficiency and better scheduling
# decisions.
# RMPOLLINTERVAL is the interval between 2 MAUI initiated queries of
# Torque for new jobs. This acts as a catch-all mechanism and should not
# be set to low if there is a large number of jobs in queue or burst
# submissions.
# If you have short queues or/and jobs it is, worth to set
# JOBAGGREGATIONTIME to a short interval (10 seconds) and
# RMPOLLINTERVAL not to high...
# But too short interval can lead to a situation where resource
# consumption is high with a large number of jobs in queue and MAUI is
# no longer responding.
#
# DEFERTIME : This is the time maui will wait before trying to reschedule a job which
# couldn't initially be scheduled because of a lack of resources.
# Set to something short if short and short-deadline jobs are
# supported on your site but not too short if you have many job slots
# (must be correlated to scheduling time).
variable MAUI_SERVER_CONFIG ?= dict();
variable MAUI_SERVER_CONFIG_DEFAULT = dict(
                                               'ADMIN1', 'root',
                                            'ADMIN_HOST', CE_HOST,
                                            'DEFERTIME', '00:05:00',
                                            'ENABLEMULTIREQJOBS', true,
                                            'ENFORCERESOURCELIMITS', 'ON',
                                            'JOBAGGREGATIONTIME', '00:00:10',
                                            'JOBPRIOACCRUALPOLICY', 'FULLPOLICY',
                                            'LOGFILE', '/var/log/maui.log',
                                            'LOGFILEMAXSIZE', 100000000,
                                            'LOGFILEROLLDEPTH', 10,
                                            'LOGLEVEL', 0,
                                            'NODEALLOCATIONPOLICY', 'MAXBALANCE',
                                            'NODEPOLLFREQUENCY', 5,
                                            'RMPOLLINTERVAL', '00:01:00',
                                            'SERVERHOST', CE_HOST,
                                            'SERVERPORT', 40559,
                                            'SERVERMODE', 'NORMAL',
                                           );


# Job priority parameters.
#
# Fair-share policy parameters.  The base scheduling policy for jobs
# uses fair-share scheduling with a correction applied for jobs staying
# a long time in queue.  This doesn't preclude short and short-
# deadline jobs from executing immediately when reservations are
# available.
variable MAUI_SERVER_POLICY ?= dict();
variable MAUI_SERVER_POLICY_DEFAULT = dict(
                                            'FSDECAY', 0.95,
                                            'FSDEPTH', 28,
                                            'FSINTERVAL', '24:00:00',
                                            # DEDICATEDPS% would be better but doesn't work - MJ (7/7/07)
                                            'FSPOLICY', 'DEDICATEDPS',
                                            # FS contribution is typically (O)10 with FSGROUPWEIGHT=10 if difference
                                            # from target is < 10
                                            'FSWEIGHT', 1,
                                            'FSGROUPWEIGHT', 20,
                                            # XFACTOR is  1+QUEUETIME/WCLIMIT. Typically < 3 for jobs spending less
                                            # than 3 days in queue (with a default WCLIMIT = 1.5 day).
                                            # XFACTORWEIGHT=10 contributes 30 if 3 days in queue. Be sure to have
                                            # fairshare contributing more for small differences with target
                                            'QUEUETIMEWEIGHT', 0,
                                            'XFACTORWEIGHT', 10,
                                           );


# MAUI resource manager configuration
variable MAUI_SERVER_RMCFG ?= dict();
variable MAUI_SERVER_RMCFG_DEFAULT ?= dict('base', 'TYPE=PBS',
                                           );

# Variable defining configuration parameters specific to site.
# Added a the end of the configuration file
variable MAUI_SERVER_CONFIG_SITE ?= undef;

# Frequency of MAUI monitoring cron
# Can be changed in case of MAUI instability...
variable MAUI_MONITORING_FREQUENCY ?= "*/15 * * * *";

# Define VO (group) specific characteristics.
# This is mainly used to define fairshare parameters.
# Key must be a group name or DEFAULT. Default entry is applied to group not explicitly defined.
variable MAUI_GROUP_PARAMS ?= dict('DEFAULT',"FSTARGET=5+");

# Define user specific characteristics.
# This is mainly used to define fairshare parameters
# Key must be a user name.
variable MAUI_USER_PARAMS ?= dict();

# Define class specific characteristics.
# This is mainly used to define fairshare parameters
# Key is a class name or DEFAULT. Default entry is applied to class not explicitly defined.
variable MAUI_CLASS_PARAMS ?= dict();

# Define account specific characteristics.
# This is mainly used to define fairshare parameters
# Key must be an account name.
variable MAUI_ACCOUNT_PARAMS ?= dict();

# MAUI standing reservation configuration.
# MAUI_STANDING_RESERVATION_CLASSES defines classes that may access the SR. This is a nlist : key
# is a WN name and value is the list of classes as a comma separated list. DEFAULT entry is used for
# when there is no entry matching WN name associated with the SR.
variable MAUI_STANDING_RESERVATION_ENABLED ?= true;
variable MAUI_STANDING_RESERVATION_CLASSES ?= {
  if ( !exists(SELF['DEFAULT']) || !is_defined(SELF['DEFAULT']) ) {
    SELF['DEFAULT'] = dict('DEFAULT', 'dteam,ops');
  };
};

# Check Torque has already been configured
variable CE_QUEUES ?= error('List of queues undefined : Torque must be configured first');

# ----------------------------------------------------------------------------
# chkconfig
# ----------------------------------------------------------------------------
include 'components/chkconfig/config';
"/software/components/chkconfig/service/maui/on" = "";
"/software/components/chkconfig/service/maui/startstop" = true;


# ----------------------------------------------------------------------------
# accounts
# ----------------------------------------------------------------------------
#include common/maui/server/user;


# ----------------------------------------------------------------------------
# iptables
# ----------------------------------------------------------------------------
#include components/iptables/config;

# Inbound port(s).

# Outbound port(s).


# ----------------------------------------------------------------------------
# etcservices
# ----------------------------------------------------------------------------
include 'components/etcservices/config';
"/software/components/etcservices/entries" =
  push("maui 15004/tcp");


# ----------------------------------------------------------------------------
# cron
# ----------------------------------------------------------------------------
#include components/cron/config;


# ----------------------------------------------------------------------------
# altlogrotate
# ----------------------------------------------------------------------------
#include components/altlogrotate/config;


# ----------------------------------------------------------------------------
# Build MAUI configuration from MAUI_SERVER_xxx variables, with
# MAUI_SERVER_CONFIG_SITE added at the end of configuration file.
# For backward compatibility, if MAUI_CONFIG already exists just use it.
# ----------------------------------------------------------------------------
include 'components/maui/config';
variable MAUI_CONFIG ?= {
  config = '';

  # Merge default parameters with site parameters
  server_config = MAUI_SERVER_CONFIG;
  foreach (param;val;MAUI_SERVER_CONFIG_DEFAULT) {
    if ( !exists(server_config[param]) ) {
      server_config[param] = val;
    };
  };
  server_policy = MAUI_SERVER_POLICY;
  foreach (param;val;MAUI_SERVER_POLICY_DEFAULT) {
    if ( !exists(server_policy[param]) ) {
      server_policy[param] = val;
    };
  };
  server_rmcfg = MAUI_SERVER_RMCFG;
  foreach (param;val;MAUI_SERVER_RMCFG_DEFAULT) {
    if ( !exists(server_rmcfg[param]) ) {
      server_rmcfg[param] = val;
    };
  };

  config = config + "\n#Server main parameters\n";
  foreach (param;val;server_config) {
    if ( is_string(val) ) {
      valstr = val;
    } else {
      valstr = to_string(val);
    };
    config = config + param + "\t\t" + valstr + "\n";
  };

  config = config + "\n# Resource manager parameters\n";
  foreach (param;val;server_rmcfg) {
    if ( is_string(val) ) {
      valstr = val;
    } else {
      valstr = to_string(val);
    };
    config = config + "RMCFG[" + param + "]\t\t" + valstr + "\n";
  };

  config = config + "\n# Job priority parameters\n";
  foreach (param;val;server_policy) {
    if ( is_string(val) ) {
      valstr = val;
    } else {
      valstr = to_string(val);
    };
    config = config + param + "\t\t" + valstr + "\n";
  };
  config = config + "\n";

  config = config + "\n# Site specific parameters\n";
  if ( is_defined(MAUI_SERVER_CONFIG_SITE) ) {
    config = config + MAUI_SERVER_CONFIG_SITE;
  };

  # maui_def_part allows to keep track that an explicit default partition
  # has been configured (instead of MAUI default 'DEFAULT')
  if ( exists(MAUI_WN_PART_DEF) && is_defined(MAUI_WN_PART_DEF) && (length(MAUI_WN_PART_DEF) > 0) ) {
    maui_def_part = MAUI_WN_PART_DEF;
  } else {
    maui_def_part = undef;
  };

  # Configure default partition used by MAUI. This is done by disabling all
  # partitions by default and adding explicitly the allowed partition for each
  # group (VO). This allows to control partition access on a per VO basis.

  if ( exists(MAUI_GROUP_PART["DEFAULT"]) && is_defined(MAUI_GROUP_PART["DEFAULT"]) ) {
    maui_def_part_list = MAUI_GROUP_PART["DEFAULT"];
  } else {
    if ( is_defined(maui_def_part) ) {
      maui_def_part_list = maui_def_part;
    } else {
      maui_def_part_list = "DEFAULT";
    };
  };

  # Group (vo) parameters.
  # Add default entry for each VO without an explicit one.
  group_list_params = MAUI_GROUP_PARAMS;

  if ( is_defined(maui_def_part_list) ) {
    config = config + "# Node partitions are used keep jobs confined to appropriate nodes.\n";
    config = config + "# By default, allow access to NO partitions.\n";
    config = config + "SYSCFG[base] PLIST=\n\n";
  };

  config = config + "\n# Define parameters and partitions for each VO (group).\n";
  group_part = '';
  foreach (group_name;group_params;group_list_params) {
    if ( is_defined(maui_def_part_list) ) {
      if ( exists(MAUI_GROUP_PART[group_name]) && is_defined(MAUI_GROUP_PART[group_name]) ) {
        group_part = "PLIST=" + MAUI_GROUP_PART[group_name];
      } else {
        group_part = "PLIST=" + maui_def_part_list;
      };
    };
    config = config + "GROUPCFG[" + group_name + "] " + group_params + " " + group_part + "\n";
  };
  config = config + "\n";

  config = config + "\n# Define user specific parameters.\n";
  foreach (user_name;user_params;MAUI_USER_PARAMS) {
    config = config + "USERCFG[" + user_name + "] " + user_params + "\n";
  };
  config = config + "\n";

  config = config + "\n# Define class specific parameters.\n";
  foreach (class_name;queue_params;CE_QUEUES['names']) {
    if ( exists(MAUI_CLASS_PARAMS[class_name]) && exists(MAUI_CLASS_PARAMS[class_name]) ) {
      class_params = MAUI_CLASS_PARAMS[class_name];
    } else if ( exists(MAUI_CLASS_PARAMS['DEFAULT']) && exists(MAUI_CLASS_PARAMS['DEFAULT']) ) {
      class_params = MAUI_CLASS_PARAMS['DEFAULT'];
    } else {
      class_params = undef;
    };
    if ( is_defined(class_params) ) {
      config = config + "CLASSCFG[" + class_name + "] " + class_params + "\n";
    };
  };
  config = config + "\n";

  config = config + "\n# Define account specific parameters.\n";
  foreach (account_name;account_params;MAUI_ACCOUNT_PARAMS) {
    config = config + "ACCOUNTCFG[" + account_name + "] " + account_params + "\n";
  };
  config = config + "\n";

  config = config + "\n# Configure each WN partition and standing reservation\n";
  foreach (k;wn;WORKER_NODES) {
    if ( exists(MAUI_WN_PART[wn]) ) {
      wn_part = MAUI_WN_PART[wn];
    } else {
      wn_part = maui_def_part;
    };
    if ( is_defined(wn_part) ) {
      config = config + "# Add node "+ wn + " to partition 'general'\n";
      if ( exists(MAUI_WN_PART[wn]) ) {
        wn_part = MAUI_WN_PART[wn];
      } else {
        wn_part = maui_def_part;
      };
      config = config + "NODECFG[" + wn + "] PARTITION=" + wn_part + "\n\n";
    };

    if ( exists(WN_CPUS[wn]) && is_defined(WN_CPUS[wn]) ) {
       process_slots = WN_CPUS[wn];
    } else {
       process_slots = WN_CPUS_DEF;
    };

    if ( MAUI_STANDING_RESERVATION_ENABLED ) {
      if ( exists(MAUI_STANDING_RESERVATION_CLASSES[wn]) && is_defined(MAUI_STANDING_RESERVATION_CLASSES[wn]) ) {
        sr_classlist = MAUI_STANDING_RESERVATION_CLASSES[wn];
      } else {
        sr_classlist = MAUI_STANDING_RESERVATION_CLASSES['DEFAULT'];
      };
      rname = "SRCFG[sdj_"+to_string(k)+"]";
      config = config + "# Job reservation for node "+wn+" shared by classes: "+sr_classlist+"\n";
      config = config + rname+" HOSTLIST="+wn+"\n";
      config = config + rname+" PERIOD=INFINITY\n";
      config = config + rname+" ACCESS=DEDICATED\n";
      config = config + rname+" PRIORITY=10\n";
      config = config + rname+" TASKCOUNT=1\n";
      config = config + rname+" RESOURCES=PROCS:"+to_string(process_slots)+"\n";
      config = config + rname+" CLASSLIST="+sr_classlist+"\n\n";
    };

  };

  config;
};

"/software/components/maui/contents" ?= MAUI_CONFIG;


# ----------------------------------------------------------------------------
# Define a cron job to ensure that MAUI is running properly
# ----------------------------------------------------------------------------
include 'components/filecopy/config';
include 'components/cron/config';
include 'components/altlogrotate/config';
variable MAUI_MONITORING_SCRIPT = "/var/spool/maui/maui-monitoring";
variable CONTENTS = <<EOF;
#!/bin/sh
exit 0

export PATH=/sbin:/usr/sbin:/bin:/usr/bin

mauibin=/usr/sbin/maui
mauisrv=maui
torquesrv=pbs_server

service $mauisrv status > /dev/null 2>&1
if [ $? -ne 0 ]
then
  echo "`date` - MAUI not running. Restarting..."
  service $mauisrv start
else
  restart_maui=0
  # Check maui is responding
  # If not, check again if maui is there as mdiag command sometimes crashes maui ...
  mdiag -S > /dev/null 2>&1
  if [ $? -ne 0 ]
  then
    mauipid=`ps -e -opid="",cmd="" | awk "{if (\\$2==\"${mauibin}\") print \\$1}"`
    if [ -z "$mauipid" ]
    then
      echo "`date` - MAUI service looked ok but MAUI not running. Restarting..."
      restart_maui=1
    else
      echo "`date` - MAUI running (pid=$mauipid) but not responding. Trying to restart Torque server..."
      service $torquesrv restart
      sleep 10

      mdiag -S > /dev/null 2>&1
      if [ $? -ne 0 ]
      then

        echo "`date` - MAUI running (pid=$mauipid) still not responding. Killing and restarting..."
        kill -KILL $mauipid
        restart_maui=1
      else
        echo "`date` - MAUI running properly after Torque restart."
      fi
    fi
    echo `date` - System load statictics :
    uptime
    vmstat
    if [ $restart_maui -eq 1 ]
    then
      service $mauisrv start
    fi
  fi
fi
EOF

# Now actually add the file to the configuration.
'/software/components/filecopy/services' =
  npush(escape(MAUI_MONITORING_SCRIPT),
        dict('config',CONTENTS,
              'owner','root:root',
              'perms', '0755'));

"/software/components/cron/entries" =
  push(dict(
    "name","maui-monitoring",
    "user","root",
    "frequency", MAUI_MONITORING_FREQUENCY,
    "command", MAUI_MONITORING_SCRIPT));

"/software/components/altlogrotate/entries/maui-monitoring" =
  dict("pattern", "/var/log/maui-monitoring.ncm-cron.log",
        "compress", true,
        "missingok", true,
        "frequency", "weekly",
        "create", true,
        "ifempty", true,
        "rotate", 6);


# ----------------------------------------------------------------------------
# Add a script to get a worker node status summary
# ----------------------------------------------------------------------------

variable MAUI_NODE_STATUS_SCRIPT = "/var/spool/maui/display_node_status";
variable CONTENTS = <<EOF;
#!/bin/ksh

nodes=$(mdiag -n | grep -v '^WARNING:' | egrep 'Drained|Running|Idle|Busy' | grep -v Total | awk '{print $1}')

for fullnode in $nodes
do
  echo "Checking node $fullnode... \c"
  node=$(echo $fullnode | awk -F. '{print $1}')

  node_status=$(mdiag -n $fullnode | grep $fullnode | head -1 | awk '{print $2}')
  if [ "$node_status" != "Idle" ]
  then
    jobs=$(showq -r | grep $node | awk '{print $1}')
    job_count=$(echo $jobs | wc -w | awk '{print $1}')
  else
    job_count=0
  fi

  if [ $job_count -eq 0 ]
  then
    echo "$node_status (Free)"
  else
    echo "$node_status ($job_count jobs running)"
  fi
done
EOF

# Now actually add the file to the configuration.
'/software/components/filecopy/services' =
  npush(escape(MAUI_NODE_STATUS_SCRIPT),
        dict('config',CONTENTS,
              'owner','root:root',
              'perms', '0755'));
