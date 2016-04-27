template machine-types/ui;

variable UI_CONFIG_SITE ?= null;

include 'machine-types/base';

# Include WN components
include 'node/ui/service';

# Add site specific configuration, if any
include return(UI_CONFIG_SITE);
include 'machine-types/post/base';
