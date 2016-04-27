unique template machine-types/hp_ilo_ipmi;

include 'machine-types/minimal';

variable IPMI_HOSTGROUP ?= "IPMI20ILO";

"/system/monitoring/hostgroups" = {
    append(SELF,IPMI_HOSTGROUP);
    append("HP_ILO_" + CLUSTER_NAME);
};
