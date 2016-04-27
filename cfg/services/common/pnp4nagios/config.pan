unique template common/pnp4nagios/config;

include 'components/pnp4nagios/config';
prefix "/software/components/pnp4nagios";
"nagios" ?= dict();
"perfdata" ?= dict();
"php" ?= dict();
