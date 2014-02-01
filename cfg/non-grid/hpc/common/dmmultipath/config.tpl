unique template common/dmmultipath/config;


include 'common/dmmultipath/packages';

"/system/monitoring/hostgroups" = append("multipath");

include {'common/dmmultipath/schema'};

bind "/software/components/metaconfig/services/{/etc/multipath.conf}/contents" = multipath_config;

prefix "/software/components/metaconfig/services/{/etc/multipath.conf}";
"daemon/0" = "multipathd";
"module" = "multipath/main";

variable DMMULTIPATH_METACONFIG ?= null;
include {DMMULTIPATH_METACONFIG};

