unique template common/nagios/config;

variable NAGIOS_NRPE_CONFIG ?= true;
## add nrpe rpms
include { if (NAGIOS_NRPE_CONFIG) {return('common/nagios/nrpe');} else {return(null);}; };
