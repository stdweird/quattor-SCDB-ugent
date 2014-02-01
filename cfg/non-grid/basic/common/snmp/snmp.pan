unique template common/snmp/snmp;

variable SNMP_MIBDIRS ?= null; # default mibdir /usr/share/snmp/mibs
variable SNMP_MIBS ?= list('ALL'); # load all in searchpath

include {'common/snmp/schema'};

bind "/software/components/metaconfig/services/{/etc/snmp/snmp.conf}/contents" = snmp_snmp_conf;
prefix "/software/components/metaconfig/services/{/etc/snmp/snmp.conf}";
"owner" = "root";
"group" = "root";
"module" = "snmp/snmp";
"mode" = 0644;

prefix "/software/components/metaconfig/services/{/etc/snmp/snmp.conf}/contents";
"mibs" = SNMP_MIBS;
"mibdirs" = SNMP_MIBDIRS;
