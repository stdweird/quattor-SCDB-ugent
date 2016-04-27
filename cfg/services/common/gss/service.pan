unique template common/gss/service;

variable GSS_VERSION ?= "1.5";

include 'common/gss/rpms/config';

variable XCAT_SSH_PUB_KEY ?= undef;
"/software/components/useraccess/users/root/ssh_keys" = append(XCAT_SSH_PUB_KEY);

variable GSS_USE_NTPD ?= 'off';
include 'components/chkconfig/config';
prefix "/software/components/chkconfig/service";
"{gpfs}" = dict("on","","startstop",true);
"{mpt2sas}" = dict("on","","startstop",true);

"{ntpd}" = dict(GSS_USE_NTPD,"","startstop",true);

"{rhsmcertd}" = dict("off","","startstop",true);
"{rhnsd}" = dict("off","","startstop",true);
"{postfix}" = dict("off","","startstop",true);

"/system/monitoring/hostgroups" = {
    append(SELF,"gpfs_servers");
    SELF;
};

include { if(GSS_VERSION != "1.5") {'common/gss/gui'}; };
