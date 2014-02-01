unique template common/snmp/snmptrapd;

variable SNMPTRAP_SEND_NSCA ?= true;

include {if(SNMPTRAP_SEND_NSCA) {'common/nagios/send_nsca/service'}};


include {'common/snmp/schema'};

bind "/software/components/metaconfig/services/{/etc/snmp/snmptrapd.conf}/contents" = snmp_snmptrapd_conf;

prefix "/software/components/metaconfig/services/{/etc/snmp/snmptrapd.conf}";
"owner" = "root";
"group" = "root";
"module" = "snmp/snmptrapd";
"mode" = 0644;
"daemon" = list('snmptrapd');

prefix "/software/components/metaconfig/services/{/etc/snmp/snmptrapd.conf}/contents/main";
"authCommunity" = value("/software/components/metaconfig/services/{/etc/snmp/snmpd.conf}/contents/main/authcommunity");

include { 'components/chkconfig/config' };
"/software/components/chkconfig/service/snmptrapd" = nlist("on", "", "startstop", true);
