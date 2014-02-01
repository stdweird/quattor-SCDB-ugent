unique template common/torque2/ui/service;

include 'common/torque2/ui/packages';

include 'common/torque2/ui/config';

# so component sets this; but is required for proper trqauthd functioning
include 'common/torque2/server_name';

# client BLCR settings
variable TORQUE_USE_BLCR ?= false;
variable BLCR_CLIENT_FLAVOUR = undef;
include { if(TORQUE_USE_BLCR) {"common/blcr/service"} };
