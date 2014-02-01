unique template common/nagios/checks/checks;

include { 'components/symlink/config' };
include { 'components/filecopy/config' };

'/software/components/nrpe/options/command' ?= nlist();

# script to be included + settings to sudoers to make them work
variable CHECKS_NAGIOS_DEF ?= {
    if(PKG_ARCH_DEFAULT == "x86_64") {
        return("/usr/lib64/nagios/plugins/");
    } else {
        return("/usr/lib/nagios/plugins/");
    };
};
variable CHECKS_LOCATION ?= CHECKS_NAGIOS_DEF+"hpc/";

variable CHECKS_INCL ?= "common/nagios/checks/";

# check number of jobs in batchhold
include { CHECKS_INCL+"batchhold_jobs" };

# check BIOS/UEFI version
include { CHECKS_INCL+"BIOS" };

# check and restart
include { CHECKS_INCL+"check_and_restart" };
include { CHECKS_INCL+"check_and_restart_opensm" };

# check disk gpfs trimmed
include { CHECKS_INCL+"check_disk_trimmed" };

# check gpfs devices
include { CHECKS_INCL+"check_gpfs_devices" };

# check IB status
include { CHECKS_INCL+"check_IB" };

# check GPFS waiters
include { CHECKS_INCL+"check_mmfs_waiters" };

# cpu
include { CHECKS_INCL+"cpu" };

# check cpu and cores v2
include {  CHECKS_INCL+"cpu_count_all" };

# check CTDB
include { CHECKS_INCL+"ctdb" };

# gpfs
include { CHECKS_INCL+"gpfs" };

# check gpfs health
include { CHECKS_INCL+"gpfs_health" };

# check IB Firmware version
include { CHECKS_INCL+"IB_firmware" };

# master
include { CHECKS_INCL+"master" };

# check link to other clusters
include { CHECKS_INCL+"masters_networks" };

# check amount of memory
include {  CHECKS_INCL+"mem_count" };

# check amount of memory v2
include {  CHECKS_INCL+"mem_count_all" };

# memory
include { CHECKS_INCL+"memory" };

# check multipath
include {  CHECKS_INCL+"multipath" };

# check number of processors
include { CHECKS_INCL+"num_cpus" };

# check powervault status and performance
include {  CHECKS_INCL+"powervault" };

# check process
include { CHECKS_INCL+"process" };

# check quattor deployments
include { CHECKS_INCL+"quattor_deployments" };

# check number of processors
include { CHECKS_INCL+"show" };

# check dell - lsi sas raid controller
include {  CHECKS_INCL+"raid_sas2ircu" };

# check devices
include { CHECKS_INCL+"stat_dev" };

# check X509 certificates
include { CHECKS_INCL+"ssl_cert" };

# Check swapping activity
include { CHECKS_INCL+"swapping" };

# check if the disk is mounted rw (readonly often means broken disk)
include {  CHECKS_INCL+"touchfs" };

# check X509 certificates
include { CHECKS_INCL+"x509" };

# check hardware inventory
include { CHECKS_INCL+"hw-inventory" };

#OTHERS
variable CHECK_NAGIOS_TIME_SERVER ?= NRPE_ALLOWED_HOSTS[0];

'/software/components/nrpe/options/command' = {
    SELF["check_disk1"] = CHECKS_NAGIOS_DEF+"check_disk -w 20 -c 10 -p /dev/hda1";
    SELF["check_disk2"] = CHECKS_NAGIOS_DEF+"check_disk -w 20 -c 10 -p /dev/hdb1";
    SELF["check_local_disks"] = CHECKS_NAGIOS_DEF+"check_disk -l -w 10% -c 5%";
    SELF["check_local_disks_tmpfs"] = CHECKS_NAGIOS_DEF+"check_disk -l -w 10% -c 5% -X ext2 -X ext3 -X ext4 -X gpfs";
    #replaced by check_disk_trimmed#SELF["check_local_disks_gpfs"] = CHECKS_NAGIOS_DEF+"check_disk -l -w 10% -c 5% -X ext2 -X ext3 -X xfs -X tmpfs";
    # cannot pass passwd properly
    #SELF["check_ldap"] = CHECKS_NAGIOS_DEF+'check_ldap -H $ARG1$ -D "$ARG2$" -P '+"'$ARG3$'"+' "$ARG4$"';
    SELF["check_load"] = CHECKS_NAGIOS_DEF+"check_load -w 15,10,5 -c 30,25,20";
    SELF["check_local_disks_local"] = CHECKS_NAGIOS_DEF+"check_disk -l -w 10% -c 5% -X gpfs -X tmpfs";
    SELF["check_mail_queue"]=CHECKS_LOCATION+"check_postqueue.sh -w 50 -c 100";
    SELF["check_mountpoint"] = CHECKS_LOCATION + 'check_mountpoints.sh $ARG1$';
    SELF["check_nw_if"] = CHECKS_LOCATION+"check_ifutil.pl -i $ARG1$ -w 90 -c 95 -p -b $ARG2$";
    SELF["check_procs_name"] = CHECKS_NAGIOS_DEF+"check_procs -w '$ARG1$' -c '$ARG2$' -C '$ARG3$'";
    SELF["check_time"] = format("%s/check_time -w 1 -c 5 -t 10 -H %s",
                                CHECKS_NAGIOS_DEF, CHECK_NAGIOS_TIME_SERVER);
    SELF["check_total_procs"] = CHECKS_NAGIOS_DEF+"check_procs -w 150 -c 200";
    SELF["check_users"]=CHECKS_NAGIOS_DEF+"check_users -w 5 -c 10";
    SELF["check_zombie_procs"] = CHECKS_NAGIOS_DEF+"check_procs -w 5 -c 10 -s Z";
    SELF["service_restart"] = "sudo /sbin/service '$ARG1$' restart";
    SELF;
};

# Allow Nagios to restart elasticsearch (which leaks memory),
# xinetd, sssd and pbs_mom (which tend to crash).
include {'components/sudo/config'};

prefix "/software/components/sudo";

"privilege_lines" = {
    foreach (i; service; list("elasticsearch", "xinetd", "pbs_mom", "trqauthd", "sssd",
                              "rsyslog")) {
        nl = nlist("host", "ALL",
                   "options", "NOPASSWD:",
                   "run_as", "ALL",
                   "user", "nagios");
	nl["cmd"] = format("/sbin/service %s restart", service);
	append(nl);
    };
    SELF;
};
