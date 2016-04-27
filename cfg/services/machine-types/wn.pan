@{
    Common worker node definition (architecture independant).
}
template machine-types/wn;

variable WN_CONFIG_SITE ?= null;

include 'machine-types/base';

# Include WN components
include 'node/wn/service';

# Add site specific configuration, if any
include WN_CONFIG_SITE;
include 'machine-types/post/base';
