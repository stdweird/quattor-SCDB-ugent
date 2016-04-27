unique template common/ganesha/config_v1;
include 'common/snmp/service';include 'components/symlink/config';
"/software/components/symlink/links" = push(dict(
    "name", "/etc/ganesha/snmp.conf",
    "target", "/etc/snmp/snmp.conf",
    "replace", dict("all","yes"),
    ));

variable GANESHA_VERSION ?= '1.5.0-1.el6.ug.1396503752.cdb3626';

variable GANESHA_LOGFILE ?= format('/var/log/%s.ganesha.nfsd.log', GANESHA_FSAL);
variable GANESHA_SNMP_ADM_LOGFILE ?= '/var/log/ganesha_snmp_adm.log';

# this is fixed, since no variables are allowed in left side of assignment
final variable GANESHA_CONFFILE = '/etc/ganesha/ganesha.nfsd.conf';

prefix "/software/components/metaconfig/services/{/etc/ganesha/ganesha.nfsd.conf}/contents/main";
'SNMP_ADM/snmp_adm_log' = GANESHA_SNMP_ADM_LOGFILE;
'SNMP_ADM/snmp_agentx_socket' = value("/software/components/metaconfig/services/{/etc/snmp/snmpd.conf}/contents/main/agentXSocket");
include 'components/sysconfig/config';
"/software/components/sysconfig/files/ganesha" = dict(
    "LOGFILE",GANESHA_LOGFILE,
    "CONFFILE",GANESHA_CONFFILE,
);
