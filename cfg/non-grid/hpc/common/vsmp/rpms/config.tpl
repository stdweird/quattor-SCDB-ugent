unique template common/vsmp/rpms/config;

include {'quattor/functions/repository'};
variable OS_REPOSITORY_LIST = append("pub_scalemp");
variable OS_REPOSITORY_LIST = append("priv_scalemp");

variable VSMPPP_VERSION ?= 'vsmppp20_20130331122500';

include { 'common/vsmp/rpms/'+VSMPPP_VERSION };

