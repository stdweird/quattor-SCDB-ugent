unique template machine-types/imm_idpx;
include 'machine-types/minimal';
"/system/monitoring/hostgroups" = {
    append(SELF,"IBM_IMM_IDPX");
    append(SELF,"IBM_IMM_IDPX_"+CLUSTER_NAME);
    if( match(value('/hardware/model'), 'With Sensors')){
    	append(SELF,"IBM_iDPX_with_sensors");
    };
    SELF;
};
