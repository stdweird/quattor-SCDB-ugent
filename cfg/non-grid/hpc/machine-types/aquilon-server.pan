@{
    Machine type representing a mirror of RPM packages.
@}
unique template machine-types/aquilon-server;

include { 'machine-types/core' };

include 'common/httpd/service';
include 'common/openvpn/service';
include 'common/quattor-server/profiles';
include 'common/aquilon/service';
include 'common/quattor-server/aii';

include 'common/freeipa/client';

prefix "/software/components/metaconfig/services/{/etc/httpd/conf.d/profiles.conf}/contents/vhosts/profiles";

"ssl/carevocationfile" = null;
"locations" = null;
"perl" = null;
