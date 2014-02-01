@{ Describes the BUOY service, assuming that we want to have the
beacon and the collector in the same host. }

unique template common/perfsonar/buoy/service;

include {'common/perfsonar/buoy/mesh'};
include {'common/perfsonar/buoy/daemon'};
include {'common/perfsonar/lookup/daemon'};
include {'common/perfsonar/lookup/registration'};

include { if (PERFSONAR_BUOY_COLLECTOR) {
	'common/perfsonar/buoy/collector';
    };
};


prefix "/software/components/chkconfig/service";

"perfsonarbuoy_bw_master" = nlist("off", "", "startstop", true);
"perfsonarbuoy_owp_master" = nlist("off", "", "startstop", true);
"perfsonarbuoy_bw_collector" ?= nlist("off", "", "startstop", true);
"perfsonarbuoy_owp_collector" ?= nlist("off", "", "startstop", true);
"perfsonarbuoy_ma" ?= nlist("off", "", "startstop", true);

"/system/monitoring/hostgroups" = append("buoy");
