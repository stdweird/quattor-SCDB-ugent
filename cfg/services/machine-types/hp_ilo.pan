unique template machine-types/hp_ilo;
include 'machine-types/minimal';
"/system/monitoring/hostgroups" = {
    append("HP_ILO");
    append("HP_ILO_" + CLUSTER_NAME);
};
