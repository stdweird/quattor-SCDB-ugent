unique template common/snmp/snmpd;

variable SNMP_SNMPD_LOCATION ?= undef;
variable SNMP_SNMPD_CONTACT ?= value("/system/rootmail");

include 'components/chkconfig/config';
"/software/components/chkconfig/service/snmpd" = dict("on", "", "startstop", true);

include 'metaconfig/snmp/snmpd';

prefix "/software/components/metaconfig/services/{/etc/snmp/snmpd.conf}/contents";
"group" = list(
    'notConfigGroup v1           notConfigUser',
    'notConfigGroup v2c           notConfigUser',
);

prefix "/software/components/metaconfig/services/{/etc/snmp/snmpd.conf}/contents/main";
"access" = 'notConfigGroup ""      any       noauth    exact  systemview none none';
"agentXRetries" = 10;
"agentXSocket" = 'tcp:localhost:705';
"agentXTimeout" = 20;
"authcommunity" = 'log,execute public';
"com2sec" = 'notConfigUser  default       public';
"master" = 'agentx';
"pass" = '.1.3.6.1.4.1.4413.4.1 /usr/bin/ucd5820stat';
"sysLocation" = SNMP_SNMPD_LOCATION;
"sysContact" = SNMP_SNMPD_CONTACT;
"trap2sink" = 'localhost';
"view" = 'systemview    included   1.3.6.1';
