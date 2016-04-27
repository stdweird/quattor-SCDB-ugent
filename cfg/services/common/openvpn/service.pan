unique template common/openvpn/service;

variable OPENVPN_SITE_CONFIG ?= undef;
include OPENVPN_SITE_CONFIG;
include 'common/openvpn/packages';
include 'common/openvpn/config';

"/system/monitoring/hostgroups" = append("openvpn_servers");

# We need to download any "secret" files before ncm-openvpn tries to
# restart the service.
"/software/components/openvpn/dependencies/pre" = append("download");

include 'common/openvpn/service/config';
