# MOAB configuration
## heavily based on maui configuration

unique template common/moab/server/config;

include 'metaconfig/moab/config_legacy';


variable MOAB_SCHEDCFG_SERVER ?= CE_HOST;
variable MOAB_SCHEDCFG_NAME ?= "myname";
variable MOAB_RMCFG_NAME ?= "myname";
variable MOAB_GOLD_SERVER ?= undef;

variable MOAB_MAIN_EXTRA ?= dict();

prefix "/software/components/metaconfig/services/{/opt/moab/etc/moab.cfg}/contents";
"main" = {
    tmp =  dict(
                'admin1', 'root',
                'defertime', '00:05:00',
                'allowmultireqnodeuse', 'true',
                'jobaggregationtime', '00:00:10',
                'jobprioaccrualpolicy', 'FULLPOLICY',
                'logdir', MOAB_HOME+'/log',
                'logfilemaxsize', '100000000',
                'logfilerolldepth', '10',
                'loglevel', '1',
                'nodeallocationpolicy', 'MAXBALANCE',
                'nodepollfrequency', '5',
                'rmpollinterval', '00:00:30,00:01:00',
                );
    foreach (k;v;MOAB_MAIN_EXTRA) {
        tmp[k] = v;
    };
    tmp;
};

variable MOAB_PRIORITY ?= dict(
    'fsdecay', '0.90',
    'fsdepth', '4',
    'fsinterval', '168:00:00',
    'fspolicy', 'DEDICATEDPS',
    'fsweight', '1',
    'fsgroupweight', '20',
    'queuetimeweight', '0',
    'xfactorweight', '10',
);
"priority" = MOAB_PRIORITY;

variable MOAB_SCHEDCFG ?= dict(
    MOAB_SCHEDCFG_NAME, list("SERVER="+MOAB_SCHEDCFG_SERVER+":40559 MODE=NORMAL FLAGS=EXTENDEDGROUPSUPPORT,FASTGROUPLOOKUP")
);
"sched" = MOAB_SCHEDCFG;

variable MOAB_RMCFG ?= dict(
  MOAB_RMCFG_NAME  , list("TYPE=PBS", "TIMEOUT=120", "FLAGS=NoCondensedQuery"),
);
"rm" = MOAB_RMCFG;

variable MOAB_AMCFG ?= {
    if (is_defined(MOAB_GOLD_SERVER)) {
        return(dict("bank", list(
                         "SERVER=gold://"+MOAB_GOLD_SERVER+" SOCKETPROTOCOL=HTTP WIREPROTOCOL=XML",
                         "CHARGEPOLICY=DEBITALLWC",
                         "JOBFAILUREACTION=HOLD",
                         "FALLBACKACCOUNT=default_project"
                         )
                    ));
     } else {
        return(null);
     };
};
"am" = MOAB_AMCFG;

variable MOAB_IDCFG ?= null;
"id" = MOAB_IDCFG;


variable MOAB_GROUPCFG ?= dict(
    "DEFAULT",list("FSTARGET=5 PLIST=DEFAULT")
);
"group" = MOAB_GROUPCFG;

variable MOAB_INCLUDES ?= null;
"include" = {
    if(is_list(MOAB_INCLUDES)) {
        foreach(idx;name;MOAB_INCLUDES) {
            append(format("%s/etc/%s", MOAB_HOME, name));
        };
    } else {
        null;
    };
};

# gzip stats files older than 15 days
"/software/components/cron/entries" = append(dict(
    "name", "moab-stats",
    "user", "root",
    "frequency", "20 4 * * *",
    "command", format("find %s/stats/* -mtime +15 -type f -exec gzip -9 {} \\;", MOAB_HOME),
    ));
