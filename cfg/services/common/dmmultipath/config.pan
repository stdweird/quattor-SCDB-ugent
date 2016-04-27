unique template common/dmmultipath/config;


include 'common/dmmultipath/packages';

"/system/monitoring/hostgroups" = append("multipath");

include 'metaconfig/devicemapper/multipath';

variable DMMULTIPATH_METACONFIG ?= null;
include DMMULTIPATH_METACONFIG;
