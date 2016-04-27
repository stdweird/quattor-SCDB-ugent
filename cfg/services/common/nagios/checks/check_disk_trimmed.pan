unique template common/nagios/checks/check_disk_trimmed;

variable SCRIPT_NAME = "check_disk_trimmed";

'/software/components/nrpe/options/command/check_local_disks_gpfs' =
    format("%s/%s -l -w 15%% -c 10%% -A -i backup -X ext4 -X ext2 -X ext3 -X tmpfs -X xfs -X nfs",
           CHECKS_LOCATION, SCRIPT_NAME);
