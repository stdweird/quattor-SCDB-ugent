unique template machine-types/ha;


include 'machine-types/core';

variable HA_TYPE ?= "heartbeat";
variable HA_TYPE = 'pacemaker';

include { format('common/%s/service', HA_TYPE) };

include 'machine-types/post/core';
