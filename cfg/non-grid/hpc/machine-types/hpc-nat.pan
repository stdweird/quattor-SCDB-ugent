unique template machine-types/hpc-nat;

final variable SYSLOG_RELAY = 'tangela.ugent.be';

final variable ETCHOSTS_TYPE = 'nat';

final variable I_AM_SINDES_SERVER = true;

include  'machine-types/core';

include 'common/nat/service';
include 'common/nginx/service';
include 'common/quattor-proxy/pkgs';
include 'common/quattor-proxy/restricted-pkgs';
include 'common/quattor-server/profiles';
include 'common/quattor-server/secrets';
include 'common/manage/service';
include 'common/named/service';

include if_exists('common/logging/service');
include 'common/vnc/service';

include 'common/quattor-server/aii';

include 'common/openvpn/server/service';

include 'common/ca/service';

# open firmware download from ipmi (still blocked by shorewall)
include 'site/http_firmware';


"/system/monitoring/hostgroups" = {
    append(SELF,"nat_nodes");
    SELF;
};

# We are the proxies!!
prefix "/software/components/spma";

"proxy" = "no";
"proxyhost" = null;
"proxyport" = null;
