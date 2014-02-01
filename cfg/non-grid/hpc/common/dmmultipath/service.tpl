unique template common/dmmultipath/service;

include { "common/dmmultipath/config" };

## add service multipathd
"/software/components/chkconfig/service/multipathd/on" = "";
"/software/components/chkconfig/service/multipathd/startstop" = true;

