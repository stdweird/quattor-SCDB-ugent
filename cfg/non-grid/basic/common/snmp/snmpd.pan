unique template common/snmp/snmpd;

variable SNMP_SNMPD_LOCATION ?= undef;
variable SNMP_SNMPD_CONTACT ?= value("/system/rootmail");

include {'common/snmp/schema'};

bind "/software/components/metaconfig/services/{/etc/snmp/snmpd.conf}/contents" = snmp_snmpd_conf;

prefix "/software/components/metaconfig/services/{/etc/snmp/snmpd.conf}";
"owner" = "root";
"group" = "root";
"module" = "snmp/snmpd";
"mode" = 0644;
"daemon" = list('snmpd');

include { 'components/chkconfig/config' };
"/software/components/chkconfig/service/snmpd" = nlist("on", "", "startstop", true);


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
