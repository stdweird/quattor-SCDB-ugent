unique template common/snmp/snmp;

variable SNMP_MIBDIRS ?= null; # default mibdir /usr/share/snmp/mibs
variable SNMP_MIBS ?= list('ALL'); # load all in searchpath

include 'metaconfig/snmp/snmp';

prefix "/software/components/metaconfig/services/{/etc/snmp/snmp.conf}/contents";
"mibs" = SNMP_MIBS;
"mibdirs" = SNMP_MIBDIRS;
