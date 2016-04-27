unique template common/build/packages;

@{This is included by all WNs and UIs}

include 'common/build/rpms/basic';
include 'common/build/rpms/rpm';
include 'common/build/rpms/docs';
include 'common/build/rpms/torque';
include 'common/build/rpms/kernel';
include 'common/environment-modules/packages';

# maven on EL7 by default
include {if (RPM_BASE_FLAVOUR_NAME == 'el7') {'common/build/rpms/quattor'}};

include 'rpms/build';
