unique template node/ui/rpms/config;

## inlcude wn rpms
include { 'node/wn/rpms/config' };

prefix "/software/packages";
'scons' = nlist();
'cmake' = nlist();
