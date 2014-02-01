unique template common/xinetd/config;

include { 'components/chkconfig/config' };
"/software/components/chkconfig/service/xinetd" = nlist("on", "", "startstop", true);

include {'common/xinetd/schema'};

variable XINETD_DEFAULT_METACONFIG = nlist(
    "owner", "root",
    "group", "root",
    "module", "xinetd/main",
    "mode", 0644,
    "daemon", list('xinetd'),
);

variable XINETD_DEFUALT_CONTENTS = nlist(
    "disable", "no",
);

variable XINETD_SERVICES_TFTP ?= false;
include {if(XINETD_SERVICES_TFTP) {'common/xinetd/services/tftp'}};
