# MOAB configuration
## heavily based on maui configuration

unique template common/moab/server/config;

include { 'components/moab/config' };

"/software/components/moab/configPath" ?= {
    if (match(MOAB_RPM_VERSION,'^[7-9]\.')) {
        return(MOAB_HOME+"/etc");
    } else {
        return(MOAB_HOME);
    };
};
"/software/components/moab/configFile" ?= "moab.cfg";

variable MOAB_SCHEDCFG_SERVER ?= CE_HOST;
variable MOAB_SCHEDCFG_NAME ?= "myname";
variable MOAB_RMCFG_NAME ?= "myname";
variable MOAB_GOLD_SERVER ?= undef;

variable MOAB_MAIN_EXTRA ?= nlist();

"/software/components/moab/main" = {
    tmp =  nlist(
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
                'rmpollinterval', '00:00:20',
                );
    foreach (k;v;MOAB_MAIN_EXTRA) {
        tmp[k] = v;
    };
    tmp;
};



variable MOAB_PRIORITY ?= nlist(
    'fsdecay', '0.90',
    'fsdepth', '4',
    'fsinterval', '168:00:00',
    'fspolicy', 'DEDICATEDPS',
    'fsweight', '1',
    'fsgroupweight', '20',
    'queuetimeweight', '0',
    'xfactorweight', '10',
);
"/software/components/moab/priority" = MOAB_PRIORITY;

variable MOAB_SCHEDCFG ?= nlist(
    MOAB_SCHEDCFG_NAME, list("SERVER="+MOAB_SCHEDCFG_SERVER+":40559 MODE=NORMAL")
);
"/software/components/moab/sched" = MOAB_SCHEDCFG;

variable MOAB_RMCFG ?= nlist(
  MOAB_RMCFG_NAME  , list("TYPE=PBS")
);
"/software/components/moab/rm" = MOAB_RMCFG;

variable MOAB_AMCFG ?= {
    if (is_defined(MOAB_GOLD_SERVER)) {
        return(nlist("bank", list(
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
"/software/components/moab/am" = MOAB_AMCFG;

variable MOAB_IDCFG ?= null;
"/software/components/moab/id" = MOAB_IDCFG;


variable MOAB_GROUPCFG ?= nlist(
    "DEFAULT",list("FSTARGET=5 PLIST=DEFAULT")
);
"/software/components/moab/group" = MOAB_GROUPCFG;

variable MOAB_INCLUDES ?= null;
"/software/components/moab/include" = MOAB_INCLUDES;
