unique template common/snmp/config;

variable SNMP_USE_SNMPD ?= true;
variable SNMP_USE_SNMPTRAPD ?= true;


include {'common/snmp/snmp'}; # client

include {if(SNMP_USE_SNMPD) {'common/snmp/snmpd'}};
include {if(SNMP_USE_SNMPTRAPD) {'common/snmp/snmptrapd'}};
