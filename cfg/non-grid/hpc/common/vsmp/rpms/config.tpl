unique template common/vsmp/rpms/config;

include {'quattor/functions/repository'};
variable OS_REPOSITORY_LIST = append("pub_scalemp");
variable OS_REPOSITORY_LIST = append("priv_scalemp");

variable VSMPPP_VERSION ?= 'vsmppp20_20140616150300';

include { 'common/vsmp/rpms/'+VSMPPP_VERSION };

