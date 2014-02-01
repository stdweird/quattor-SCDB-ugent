# Torque server configuration

unique template common/torque2/server/config;

# include configuration common to client and server
include { 'common/torque2/config' };


# Queues to configure but not to export on the CE
variable CE_LOCAL_QUEUES ?= undef;

variable CE_SERVER_NAME ?= CE_HOST;

variable CE_MANAGERS = {
  if (exists(CE_PRIV_HOST) && is_defined(CE_PRIV_HOST)) {
    return("root@"+CE_PRIV_HOST+",root@"+CE_HOST);
  } else {
    return("root@"+CE_HOST);
  };
};
variable CE_OPERATORS ?= CE_MANAGERS;

# Default server attributes
variable TORQUE_SERVER_ATTRS_DEFAULT = nlist(
     "acl_host_enable", false,
     "default_node", "lcgpro",
     "default_queue", "undefined",
     "job_stat_rate", 300,
     "log_events", 511,
     "log_file_max_size", 0,
     "log_file_roll_depth", 10,
     "log_level", 0,
     "mail_from", "adm",
     "managers", '\"'+CE_MANAGERS+'\"',
     "mail_domain", CE_HOST,
     "mom_job_sync", true,
     "node_check_rate", 600,
     "node_pack", false,
     "node_ping_rate", 300,
     "operators", '\"'+CE_OPERATORS+'\"',
     "poll_jobs", true,
     "query_other_jobs", true,
     "scheduler_iteration", 600,
     "scheduling", true,
     "server_name",CE_SERVER_NAME,
     "tcp_timeout", 90,
     "moab_array_compatible", true
);

# variable allowing to customize default server attributes
variable TORQUE_SERVER_ATTRS ?= nlist();

# ----------------------------------------------------------------------------
# chkconfig
# Be sure not to start MOM on CE, in case it was started during RPM installation
# or by mistake
# ----------------------------------------------------------------------------
include { 'components/chkconfig/config' };

prefix "/software/components/chkconfig/service";
"pbs_mom" = nlist("off", "", "startstop", true);
"pbs_sched" = nlist("off", "", "startstop", true);
"pbs_server" = nlist("on", "", "startstop", true);


# ----------------------------------------------------------------------------
# cron
# ----------------------------------------------------------------------------
include { 'components/cron/config' };

"/software/components/cron/entries" =
  push(
  	nlist(
    	"name","server-logs",
    	"user","root",
    	"frequency", "33 3 * * *",
    	"command", "find /var/spool/pbs/server_logs -mtime +7 -exec gzip -9 {} \\;"),
    nlist(
    	"name","server-logs-cleanup",
    	"user","root",
    	"frequency", "54 3 * * *",
    	"command", "find /var/spool/pbs/server_logs/* -mtime +14 -exec rm -f {} \\;"),
    nlist(
    	"name","accounting-logs",
    	"user","root",
    	"frequency","20 4 * * *",
    	"command","find /var/spool/pbs/server_priv/accounting/* -mtime +1 -regex '.*[0-9]$' -exec gzip -9 {} \\;",
    	)
    );

# ----------------------------------------------------------------------------
# altlogrotate
# ----------------------------------------------------------------------------
include { 'components/altlogrotate/config' };

"/software/components/altlogrotate/entries/server-logs" =
  nlist("pattern", "/var/log/server-logs.ncm-cron.log",
        "compress", true,
        "missingok", true,
        "frequency", "weekly",
        "create", true,
        "ifempty", true,
        "rotate", 1);

# ----------------------------------------------------------------------------
## sysconfig
# ----------------------------------------------------------------------------
include { 'components/sysconfig/config' };

## force the server_name
prefix "/software/components/sysconfig/files/pbs_server";
"PBS_ARGS" = format("'-H %s'", CE_SERVER_NAME);


# ----------------------------------------------------------------------------
# pbsserver
# ----------------------------------------------------------------------------
include { 'components/pbsserver/config' };

prefix "/software/components/pbsserver";
"env/PATH" = "/bin:/usr/bin";
"env/LANG" = "C";
"dependencies/pre" = append("sysconfig");

"pbsroot" = TORQUE_HOME_SPOOL;

variable TORQUE_KEEP_COMPLETED ?= true;
# To enable torque to keep track of completed jobs, uncomment this line.
"env/TORQUEKEEPCOMPLETED" = {
    if(TORQUE_KEEP_COMPLETED) {
        'TRUE';
    } else {
        'FALSE';
    };
};

# Setup the server attributes.
"server" = {
  	SELF['manualconfig'] =  false;

  	if ( !exists(SELF['attlist']) || !is_defined(SELF['attlist']) ) {
    	SELF['attlist'] = nlist();
  	};
  	foreach (attr;val;TORQUE_SERVER_ATTRS_DEFAULT) {
    	SELF['attlist'][attr] = val;
  	};
   	foreach (attr;val;TORQUE_SERVER_ATTRS) {
    	SELF['attlist'][attr] = val;
  	};

  	SELF;
};


## check the blcr checkpoint_dir
## set proper permissions on directory
include { 'components/dirperm/config' };
"/software/components/dirperm/paths" = {
    if(path_exists('/software/components/pbsserver/server/attlist/checkpoint_dir')) {
      append(SELF,nlist(
            "path", value('/software/components/pbsserver/server/attlist/checkpoint_dir'),
            "owner", "root:root",
            "perm", "0774",
            "type", "d")
      );
      ## for some reason add this too (v4 crashes if not found
      append(SELF,nlist(
            "path", '/var/spool/pbs/checkpoint',
            "owner", "root:root",
            "perm", "0774",
            "type", "d")
      );
    };
};


#
# The default is to create one queue per VO.
#
variable CE_QUEUES ?= nlist();

#
# These queue defaults will be used unless specific
# attributes are defined in the CE_QUEUES variable.
# Default values for queue attributes are overriden on
# a per attribute basis (not per queue).
#
variable CE_QUEUE_DEFAULTS ?= nlist(
  "queue_type", "Execution",
  "resources_max.cput", "24:00:00",
  "resources_max.walltime", "36:00:00",
);


# Default value for queue 'enabled' and 'started' attributes.
# If these attributes are also defined in CE_QUEUE_DEFAULTS, they are
# overridden.
# Default value is based on variable CE_STATUS to support draining or closing
# the CE. CE_STATUS valid values are :
#   - 'Production' : enabled=true, started=true (Defaults)
#   - 'Queuing' (job accepted but not executded) : enabled=true, started=false
#   - 'Draining' (no new job accepted) : enabled=false, started=true
#   - 'Closed' : enabled=false, started=false
variable CE_QUEUE_STATE_DEFAULTS ?= {
  state_defaults = nlist();
  if ( !exists(CE_STATUS) || !is_defined(CE_STATUS) || (CE_STATUS == 'Production') ) {
    state_defaults["enabled"] = true;
    state_defaults["started"] = true;
  } else if ( CE_STATUS == 'Queuing' ) {
    state_defaults["enabled"] = true;
    state_defaults["started"] = false;
  } else if ( CE_STATUS == 'Draining' ) {
    state_defaults["enabled"] = false;
    state_defaults["started"] = true;
  } else if ( CE_STATUS == 'Closed' ) {
    state_defaults["enabled"] = false;
    state_defaults["started"] = false;
  } else {
    error("Invalid CE_STATUS value ("+CE_STATUS+")");
  };
  return(state_defaults);
};



# Setup the queues.
"/software/components/pbsserver/queue" = {

  queuelist = nlist();

  keep_running_state = nlist();
  keep_running_list = CE_KEEP_RUNNING_QUEUES;
  ok = first(keep_running_list, i, queue);
  while (ok) {
    keep_running_state[queue] = nlist('enabled', true,
                                      'started', true,
                                     );
    ok = next(keep_running_list, i , queue);
  };

  qnames = CE_QUEUES['names'];
  atts = CE_QUEUES['attlist'];

  atts_defaults = CE_QUEUE_DEFAULTS;
  ok = first(qnames,k,v);
  while (ok) {
    if (exists(CE_QUEUES['lrms'][k]) ) {
      mylrms=CE_QUEUES['lrms'][k];
    }
    else {
      mylrms=CE_BATCH_SYS;
    };
    if (mylrms=='pbs' || mylrms == 'lcgpbs' || mylrms=='torque') {
      queuelist[k] = nlist();
      queuelist[k]['manualconfig'] = false;
      if ( exists(keep_running_state[k]) ) {
        queuelist[k]['attlist'] = keep_running_state[k];
      } else {
        queuelist[k]['attlist'] = CE_QUEUE_STATE_DEFAULTS;
      };
      # Apply defaults
      if (exists(atts_defaults) && is_defined(atts_defaults)) {
        ok_atts = first(atts_defaults, att_name, att_value);
        while (ok_atts) {
          queuelist[k]['attlist'][att_name] = att_value;
          ok_atts = next(atts_defaults, att_name, att_value);
        };
      };
      # If specific attributes have been specified for the
      # current queue, add/replace them to the default attribute values
      if (exists(atts[k]) && is_defined(atts[k])) {
        ok_atts = first(atts[k], att_name, att_value);
        while (ok_atts) {
          queuelist[k]['attlist'][att_name] = att_value;
          ok_atts = next(atts[k], att_name, att_value);
        };
      };
    };
    ok = next(qnames,k,v);
  };

  return(nlist("manualconfig", false,"queuelist", queuelist));
};


# Get the number of CPUs from hardware or not
variable WN_CPUS_FROMTEMPLATE ?= false;
variable WORKERNODE_TEMPLATE_PREFIX ?= '';
variable WORKERNODE_DEFAULT_NODE ?= WORKER_NODES[0];

function profile_node_remap = {
    wn=ARGV[0];
    if (is_defined(TORQUE_DOMAIN)) {
        ## torque doamin starts with .
        wn=replace(TORQUE_DOMAIN+'$','.'+DEFAULT_DOMAIN,wn);
    };
    if (match(wn, FULL_HOSTNAME)) {
        ## this is the master, no remote template needed
        txt='';
    } else {
        txt=format("%s%s:",WORKERNODE_TEMPLATE_PREFIX,wn);
    };

    txt;
};

## get it form actual node
variable WN_CPUS_DEF ?= {
    if (WN_CPUS_FROMTEMPLATE) {
        length(value(format("%s:/hardware/cpu",profile_node_remap(WORKERNODE_DEFAULT_NODE))));
    } else {
        1;
    };
};

# Assume 1 job slot per core
## - previous default was 2 per core: one real, on maui SR
variable WN_CPU_SLOTS_PER_CORE ?= 1;
variable WN_CPU_SLOTS_DEF ?= {
    if (WN_CPUS_FROMTEMPLATE) {
        WN_CPU_SLOTS_PER_CORE*to_long(value(format("%s%s:/hardware/cpu/0/cores",WORKERNODE_TEMPLATE_PREFIX,WORKERNODE_DEFAULT_NODE)));
    } else {
        2;
    };
};

# Setup the nodes.
# Specific attributes can be set on specific nodes using WN_ATTRS
# variable. This variable is a nlist with one entry per node plus a default
# entry (key DEFAULT). DEFAULT entry if present is always applied before
# node specific entry. Each entry must be a nlist.
"/software/components/pbsserver/node" = nlist("manualconfig", false);
"/software/components/pbsserver/node/nodelist" = {
    nodes = nlist();
    wns = WORKER_NODES;
    if ( exists(WN_ATTRS) && is_defined(WN_ATTRS) && is_nlist(WN_ATTRS) ) {
        wn_attrs = WN_ATTRS;
    };
    foreach(idx;wn;wns) {
        if (WN_CPUS_FROMTEMPLATE) {
            tmp_cpus=length(value(format("%s/hardware/cpu",profile_node_remap(wn))));
        } else if ( exists(WN_CPUS[wn]) && is_defined(WN_CPUS[wn]) ) {
            tmp_cpus = to_long(WN_CPUS[wn]);
        } else {
            tmp_cpus = to_long(WN_CPUS_DEF);
        };

        if (WN_CPUS_FROMTEMPLATE) {
            tmp_slots=WN_CPU_SLOTS_PER_CORE*to_long(value(format("%s/hardware/cpu/0/cores",profile_node_remap(wn))));
        } else if ( exists(WN_CPU_SLOTS[wn]) && is_defined(WN_CPU_SLOTS[wn]) ) {
            tmp_slots = to_long(WN_CPU_SLOTS[wn]);
        } else  {
            tmp_slots = to_long(WN_CPU_SLOTS_DEF);
        };

        process_slots= to_long(tmp_cpus*tmp_slots);
        nodes[wn]["manualconfig"] = false;
        nodes[wn]["attlist"] = nlist(
            "np", process_slots,
        );
        # Add other attributes defined in either DEFAULT or node specific entry
        att_entries = list("DEFAULT",wn);
        foreach(e_k;e_v;att_entries) {
            if ( exists(wn_attrs[e_v]) && is_defined(wn_attrs[e_v]) ) {
                if ( is_nlist(wn_attrs[e_v]) ) {
                    foreach(att_name;att_value;wn_attrs[e_v]) {
                        nodes[wn]["attlist"][att_name] = att_value;
                    };
                } else {
                    error(format("WN_ATTR_DEFAULTS entry %s value for workernode %s must be a nlist",e_v,wn));
                };
            };
        };
    };
    nodes;
};


## push submitfilter through another way
#variable TORQUE_SUBMIT_FILTER_DEFAULT ?= "common/torque2/server/files/default_submitfilter.pl";
variable TORQUE_SUBMIT_FILTER_DEFAULT ?= null;
variable TORQUE_IGNORE_TORQUECFG ?= true;
"/software/components/pbsserver/ignoretorquecfg" = TORQUE_IGNORE_TORQUECFG;
"/software/components/pbsserver/submitfilter" = {
  	submit_filter = null;
  	if ( exists(TORQUE_SUBMIT_FILTER) &&
    		is_defined(TORQUE_SUBMIT_FILTER) &&
       		is_nlist(TORQUE_SUBMIT_FILTER) ) {
    	if ( exists(TORQUE_SUBMIT_FILTER[CE_HOST]) && is_defined(TORQUE_SUBMIT_FILTER[CE_HOST]) ) {
      		submit_filter = TORQUE_SUBMIT_FILTER[CE_HOST];
    	} else if ( exists(TORQUE_SUBMIT_FILTER['DEFAULT']) && is_defined(TORQUE_SUBMIT_FILTER['DEFAULT']) ) {
      		submit_filter = TORQUE_SUBMIT_FILTER['DEFAULT'];
    	};
  	};
  	if ( !is_defined(submit_filter) && is_defined(TORQUE_SUBMIT_FILTER_DEFAULT)) {
    	submit_filter = file_contents(TORQUE_SUBMIT_FILTER_DEFAULT);
  	};

  	submit_filter;
};


variable TORQUE_PBS_MONITORING ?= false;

include {if(TORQUE_PBS_MONITORING) {'common/torque2/server/pbs_monitoring'}};
