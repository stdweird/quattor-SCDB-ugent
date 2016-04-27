unique template machine-types/pre/one-hypervisor;
include if_exists('site/openvswitch/variables');
# very very basic
final variable FILESYSTEM_LAYOUT_CONFIG_SITE ?= 'site/filesystems/one-hypervisor';
variable VSC_NETWORK ?= true;

include 'site/one/common-variables';
