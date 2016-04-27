unique template common/snmp/snmptrapd;

variable SNMPTRAP_SEND_NSCA ?= true;

include {if(SNMPTRAP_SEND_NSCA) {'common/nagios/send_nsca/service'}};


include 'metaconfig/snmp/snmptrapd';

prefix "/software/components/metaconfig/services/{/etc/snmp/snmptrapd.conf}/contents/main";
"authCommunity" = value("/software/components/metaconfig/services/{/etc/snmp/snmpd.conf}/contents/main/authcommunity");

include 'components/chkconfig/config';
"/software/components/chkconfig/service/snmptrapd" = dict("on", "", "startstop", true);
