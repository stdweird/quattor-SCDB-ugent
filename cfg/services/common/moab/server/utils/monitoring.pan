unique template common/moab/server/utils/monitoring;

## some scripts + cronjobs
include 'components/filecopy/config';
include 'components/cron/config';
include 'components/altlogrotate/config';
variable MOAB_MONITORING_SCRIPT = "/var/spool/moab/moab-monitoring.sh";
'/software/components/filecopy/services' = copy_file(MOAB_MONITORING_SCRIPT,"common/moab/server/files/moab-monitoring.sh",0);

variable MOAB_MONITORING_FREQUENCY ?= "*/15 * * * *";
"/software/components/cron/entries" = push(dict(
    "name","moab-monitoring",
    "user","root",
    "frequency", MOAB_MONITORING_FREQUENCY,
    "command", MOAB_MONITORING_SCRIPT)
);


"/software/components/altlogrotate/entries/moab-monitoring" = dict(
    "pattern", "/var/log/moab-monitoring.ncm-cron.log",
    "compress", true,
    "missingok", true,
    "frequency", "weekly",
    "create", true,
    "ifempty", true,
    "rotate", 6
);


variable MAUI_NODE_STATUS_SCRIPT = MOAB_HOME+"/display_node_status.sh";
'/software/components/filecopy/services' = copy_file(
        MAUI_NODE_STATUS_SCRIPT,
        "common/moab/server/files/display_node_status.sh",
        0
);
