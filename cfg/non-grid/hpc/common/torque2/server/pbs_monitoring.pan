unique template common/torque2/server/pbs_monitoring;

# ----------------------------------------------------------------------------
# Define a cron job to ensure that PBS server is running properly
# ----------------------------------------------------------------------------
include { 'components/filecopy/config' };
include { 'components/cron/config' };
include { 'components/altlogrotate/config' };

variable PBS_MONITORING_SCRIPT = "/var/spool/pbs/pbs-monitoring";

# Now actually add the file to the configuration.
'/software/components/filecopy/services' = copy_file(PBS_MONITORING_SCRIPT,"common/torque2/server/files/pbs_monitoring.sh",0);

"/software/components/cron/entries" =
  push(nlist(
    "name","pbs-monitoring",
    "user","root",
    "frequency", "5,20,35,50 * * * *",
    "command", PBS_MONITORING_SCRIPT));

"/software/components/altlogrotate/entries/pbs-monitoring" =
  nlist("pattern", "/var/log/pbs-monitoring.ncm-cron.log",
        "compress", true,
        "missingok", true,
        "frequency", "monthly",
        "create", true,
        "ifempty", true,
        "rotate", 1);
