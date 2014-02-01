# Template configuring Torque client.
# It should not be executed on Torque server

unique template common/torque2/client/config;

# This variable is normally defined as part of VO configuration
variable CE_SHARED_HOMES ?= false;

# Variable to force MOM startup even if the current node is node in
# worker node list.
variable TORQUE_FORCE_MOM_STARTUP ?= false;

# include configuration common to client and server
include { 'common/torque2/config' };

# ----------------------------------------------------------------------------
# chkconfig
# ----------------------------------------------------------------------------
include { 'components/chkconfig/config' };

# Variable to define where is the working area for jobs on WN.
# Default value used if TORQUE_TMPDIR not previously defined.
# If TORQUE_TMPDIR is null, don't define Torque client tmpdir attribue.
variable TORQUE_TMPDIR = if ( exists(TORQUE_TMPDIR) &&
                              (is_defined(TORQUE_TMPDIR) || is_null(TORQUE_TMPDIR)) ) {
                           return(SELF);
                         } else {
                           return(TORQUE_HOME_SPOOL+"/tmpdir");
                         };


# Enable and start MOM service only if the node is listed as a worker
# node in site configuration, except if TORQUE_FORCE_MOM_STARTUP is true.
# This is done to avoid potential error messages on Torque master when
# client tries to contact server.
variable WN_REGEXP ?= "^WONTEVERMATCH%$";
"/software/components/chkconfig/service/pbs_mom" = {
  	if ( exists(WORKER_NODES_NLIST[FULL_HOSTNAME]) || TORQUE_FORCE_MOM_STARTUP || (!match(FULL_HOSTNAME,NO_WN_REGEXP) && match(FULL_HOSTNAME,WN_REGEXP))) {
		nlist('on', '', 'startstop', true);
  } else {
		nlist('off', '', 'startstop', true);
  };
};

variable PBS_NODE_NAME ?= FULL_HOSTNAME;

include { 'components/sysconfig/config' };
## force the node name matching the nodes defined in
"/software/components/sysconfig/files/pbs_mom" = {
    if (is_defined(SELF) && is_nlist(SELF) ) {
        t=SELF;
    } else {
        t=nlist();
    };
    t["args"]="'-H "+PBS_NODE_NAME+"'";
    t;
};


# ----------------------------------------------------------------------------
# pbsclient
# ----------------------------------------------------------------------------
include { 'components/pbsclient/config' };
include { 'components/profile/config' };

prefix "/software/components/pbsclient";
"behaviour" = "OpenPBS";
"pbsroot" = TORQUE_HOME_SPOOL;

"initScriptPath" = "/etc/init.d/pbs_mom";
variable PBSCLIENT_RESTRICTED ?= list(TORQUE_SERVER_HOST);
"restricted" = PBSCLIENT_RESTRICTED;

variable PBSCLIENT_ALIASES ?= null;
"aliases" = PBSCLIENT_ALIASES;

"logEvent" = 255;

"tmpdir" = TORQUE_TMPDIR;

# Report working area usage/size for easier monitoring
"resources" = {
    if ( !is_null(TORQUE_TMPDIR) ) {
        push('size[fs='+TORQUE_TMPDIR+']');
     } else {
       return(null);
     };
};
## pro/epilogue timeout in seconds (default is 300)
variable TORQUE_PROLOGALARM ?= null;
"prologAlarmSec" = TORQUE_PROLOGALARM;

## client_to_svr timeout (used by mom to start interactive session: default 50k)
variable TORQUE_MOM_CLIENT_TO_SVR_TIMEOUT_MICROSEC ?= null;
"max_conn_timeout_micro_sec" = TORQUE_MOM_CLIENT_TO_SVR_TIMEOUT_MICROSEC;

variable PBSCLIENT_NODECHECKSCRIPTPATH ?= null;
variable PBSCLIENT_NODECHECKSCRIPTINTERVAL ?= null;
"node_check_script" = PBSCLIENT_NODECHECKSCRIPTPATH;
"node_check_interval" = PBSCLIENT_NODECHECKSCRIPTINTERVAL;


"directPaths" = {
  directpaths = SELF;
  if ( !is_defined(directpaths) || !is_list(directpaths) ) {
    directpaths = list();
  };

  # Do nothing if CE_SHARED_HOMES is false
  if (!	CE_SHARED_HOMES) {
  	#return(null);
  	return(SELF);
  };

  wn_mnts = nlist();
  if ( exists(WN_SHARED_AREAS) && is_defined(WN_SHARED_AREAS) ) {
    if ( ! is_nlist(WN_SHARED_AREAS) ) {
      error("WN_SHARED_AREAS must be a nlist");
    };
    wn_mnts = WN_SHARED_AREAS;
  };

  # If WN_SHARED_AREAS is defined, add all the filesystems defined
  # to directpaths as home directories are not necessarily under /home.
  # Entries not related to home directory are not really needed but there
  # is no side effect to add them.
  if ( length(wn_mnts) > 0 ) {
    ok = first(wn_mnts, e_mnt_point, mnt_path);
    while (ok) {
      mnt_point = unescape(e_mnt_point);
      directpaths[length(directpaths)] =
    	              #nlist("locations",'*.'+DOMAIN+':'+mnt_point,
                      nlist("locations",'*'+':'+mnt_point,
    	                    "path",mnt_point,
    		           );
      ok = next(wn_mnts, e_mnt_point, mnt_path);
    };

  # If WN_SHARED_AREAS is not defined or is empty (but CE_SHARED_HOME is true),
  # add /home to directpaths for backward compatibility
  } else {
    directpaths[length(directpaths)] = nlist("locations",'*.'+DOMAIN+':/home',
                                             "path","/home"
                                            );
  };

  directpaths;
};

# ----------------------------------------------------------------------------
include { 'components/filecopy/config' };

# ----------------------------------------------------------------------------
# cron
# ----------------------------------------------------------------------------
include { 'components/cron/config' };

"/software/components/cron/entries" =
  push(nlist(
    "name","mom-logs",
    "user","root",
    "frequency", "33 3 * * *",
    "command", "find "+TORQUE_HOME_SPOOL+"/mom_logs -mtime +7 -exec gzip -9 {} \\;"));


# ----------------------------------------------------------------------------
# altlogrotate
# ----------------------------------------------------------------------------
include { 'components/altlogrotate/config' };

"/software/components/altlogrotate/entries/mom-logs" =
  nlist("pattern", "/var/log/mom-logs.ncm-cron.log",
        "compress", true,
        "missingok", true,
        "frequency", "weekly",
        "create", true,
        "ifempty", true,
        "rotate", 1);

include { 'components/sysconfig/config' };
prefix "/software/components/sysconfig/files/pbs_mom";
'BIN_PATH' = TORQUE_USR_BIN;
'SBIN_PATH' = TORQUE_USR_SBIN;
'PBS_DAEMON' = TORQUE_USR_SBIN+"/pbs_mom";
'PBS_HOME' = TORQUE_HOME_SPOOL;

## force the node name matching the nodes defined in
variable PBS_MOM_UNPRIVILEGED_PORTS ?= false;
## actually this should be called wait for server
variable PBS_MOM_WAIT_FOR_MOM ?= false;
"args"= {
    txt = '';
    if (is_defined(PBS_NODE_NAME)){
        txt = format("%s -H %s",txt,PBS_NODE_NAME);
    };
    if (PBS_MOM_UNPRIVILEGED_PORTS) {
        txt = txt+' -x';
    };
    if (PBS_MOM_WAIT_FOR_MOM) {
        txt = txt+' -w';
    };

    if (length(txt) == 0) {
        null;
    } else {
    	format("'%s'",txt);
    };
};


