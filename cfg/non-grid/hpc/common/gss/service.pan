unique template common/gss/service;

include 'common/gss/rpms/config';

variable XCAT_SSH_PUB_KEY ?= undef;
"/software/components/useraccess/users/root/ssh_keys" = append(XCAT_SSH_PUB_KEY);

variable GSS_USE_NTPD ?= 'off';

include {'components/chkconfig/config'};
prefix "/software/components/chkconfig/service";
"{gpfs}" = nlist("on","","startstop",true);
"{mpt2sas}" = nlist("on","","startstop",true);

"{ntpd}" = nlist(GSS_USE_NTPD,"","startstop",true);

"{rhsmcertd}" = nlist("off","","startstop",true);
"{rhnsd}" = nlist("off","","startstop",true);
"{postfix}" = nlist("off","","startstop",true);

"/system/monitoring/hostgroups" = {
    append(SELF,"gpfs_servers");
    SELF;
};
