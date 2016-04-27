unique template common/gpfs/snmp;
include 'common/gpfs/rpms/snmp';
variable GPFS_SNMP_SERVER ?= undef;
variable GPFS_SNMP_SEND_IP ?= undef;
include 'common/snmp/service';
"/software/components/metaconfig/services/{/etc/snmp/snmptrapd.conf}/contents/traphandle" = {
    exe='/usr/bin/handle_nsca_traps.py';
    append(format('%s %s -T %s -t %s,%s --suffixlist=%s,%s','1.3.6.1.4.1123.4.500',exe,'ds3200',GPFS_SNMP_SEND_IP[0],GPFS_SNMP_SEND_IP[1],GPFS_SNMP_SERVER[0],GPFS_SNMP_SERVER[1]));
    append(format('%s %s -T %s -t %s,%s','1.3.6.1.4.1.11.2.51*',exe,'p2000',GPFS_SNMP_SEND_IP[0],GPFS_SNMP_SEND_IP[1]));
    append(format('%s %s -T %s -t %s,%s','1.3.6.1.4.1.2.6.212*',exe,'gpfs',GPFS_SNMP_SEND_IP[0],GPFS_SNMP_SEND_IP[1]));
    append(format('%s %s -t %s,%s','default',exe,GPFS_SNMP_SEND_IP[0],GPFS_SNMP_SEND_IP[1]));
};


## libsnmp.so.10 -> libsnmp.so
## add: ln -s /usr/lib64/libnetsnmp.so.10 /usr/lib64/libnetsnmp.so
variable GPFS_SNMP_LIB_VERSION_SUFFIX ?= {
    if (RPM_BASE_FLAVOUR == '6') {
        return("20");
    } else {
        return("10");
    };
};
"/software/components/symlink/links" = {
    names=list('snmp','netsnmp','netsnmpagent','netsnmphelpers','netsnmpmibs','netsnmptrapd');
    foreach(idx;v;names) {
        append(dict("name", "/usr/lib64/lib"+v+".so",
                   "target", "/usr/lib64/lib"+v+".so."+GPFS_SNMP_LIB_VERSION_SUFFIX,
                   "exists", false,
                   "replace", dict("all","yes"),
                    ));
    };
    if (RPM_BASE_FLAVOUR == '6') {
        append(dict("name", "/usr/lib64/libperl.so",
                     "target", "/usr/lib64/perl5/CORE/libperl.so",
                     "exists", false,
                     "replace", dict("all","yes"),
                      ));
        append(dict("name", "/lib64/libwrap.so",
                     "target", "/lib64/libwrap.so.0",
                     "exists", false,
                     "replace", dict("all","yes"),
                      ));

    };
    SELF;
};

"/system/monitoring/hostgroups" = {
    append(SELF,'storage_gpfs_traps_servers');
    SELF;
};

## mmchnode -N storage --nosnmp-agent
## mmchnode -N storage --snmp-agent
