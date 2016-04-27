unique template common/xinetd/config;

include 'components/chkconfig/config';
"/software/components/chkconfig/service/xinetd" = dict("on", "", "startstop", true);

variable XINETD_SERVICES_TFTP ?= false;
include {if(XINETD_SERVICES_TFTP) {'common/xinetd/services/tftp'}};

variable XINETD_SERVICES_TIMESTREAM ?= false;
include {if(XINETD_SERVICES_TIMESTREAM) {'common/xinetd/services/time-stream'}};
