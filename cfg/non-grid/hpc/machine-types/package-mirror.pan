@{
    Machine type representing a mirror of RPM packages.
}
unique template machine-types/package-mirror;

include { 'machine-types/core' };

variable UPSTREAM_REPOS_TEMPLATE ?= 'site/repositories/upstream';

include 'common/httpd/service';

include 'common/yum-mirror/service';

include 'common/openvpn/service';
#
# updates
#
include { 'update/config' };
