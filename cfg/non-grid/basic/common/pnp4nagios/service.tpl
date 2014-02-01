unique template common/pnp4nagios/service;

include { 'common/pnp4nagios/config' };
include { 'common/pnp4nagios/packages' };

include {'components/chkconfig/config'};

"/software/components/chkconfig/service/npcd" = nlist(
    "startstop", true,
    "on", "",
);

# the httpd/conf.d/pnp4nagios.conf from the rpm contains an alias already
# it will be redefined in the icinga ssl.conf config
