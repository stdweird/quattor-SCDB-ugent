unique template common/ganesha/config;

include {'common/snmp/service'};

include { 'components/symlink/config' };
"/software/components/symlink/links" = push(nlist(
    "name", "/etc/ganesha/snmp.conf",
    "target", "/etc/snmp/snmp.conf",
    "replace", nlist("all","yes"),
    ));


variable GANESHA_VERSION ?= '1.5.0-1.el6.ug.1383170669.69f0338';

variable GANESHA_LOGFILE ?= format('/var/log/%s.ganesha.nfsd.log',GANESHA_FSAL);
variable GANESHA_SNMP_ADM_LOGFILE ?= '/var/log/ganesha_snmp_adm.log';

# this is fixed, since no variables are allowed in left side of assignment
final variable GANESHA_CONFFILE = '/etc/ganesha/ganesha.nfsd.conf';


include {'components/metaconfig/config'};
include {'common/ganesha/schema'};

bind "/software/components/metaconfig/services/{/etc/ganesha/ganesha.nfsd.conf}/contents" = ganesha_config;

prefix "/software/components/metaconfig/services/{/etc/ganesha/ganesha.nfsd.conf}";
"daemon" = {if (CTDB_MANAGES_GANESHA) { null } else { list(GANESHA_SERVICE) }};
"module" = "ganesha/main";

prefix "/software/components/metaconfig/services/{/etc/ganesha/ganesha.nfsd.conf}/contents/main";
'SNMP_ADM/snmp_adm_log' = GANESHA_SNMP_ADM_LOGFILE;
'SNMP_ADM/snmp_agentx_socket' = value("/software/components/metaconfig/services/{/etc/snmp/snmpd.conf}/contents/main/agentXSocket");

# FSAL settings
include { 'common/ganesha/fsal/'+GANESHA_FSAL };

variable GANESHA_SITE ?= 'site/ganesha';
include {GANESHA_SITE};

include {'components/sysconfig/config'};
"/software/components/sysconfig/files/ganesha" = nlist(
    "LOGFILE",GANESHA_LOGFILE,
    "CONFFILE",GANESHA_CONFFILE,
);
