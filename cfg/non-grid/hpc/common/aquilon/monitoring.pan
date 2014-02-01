@{
NRPE check for the Aquilon broker
@}

unique template common/aquilon/monitoring;

prefix "/software/components/nrpe/options/command";

"check_procs_aqd" =
    "/usr/lib64/nagios/plugins/check_procs -c 1:1 -a aqd -C python";
"check_aqd" = "/usr/lib64/nagios/plugins/hpc/check_aqd.sh";
