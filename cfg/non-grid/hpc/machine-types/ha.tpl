unique template machine-types/ha;


include { 'machine-types/core' };

variable HA_TYPE ?= "heartbeat";
variable HA_TYPE = 'pacemaker';

include { 'common/'+HA_TYPE+'/service' };