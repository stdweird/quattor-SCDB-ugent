unique template common/collectl/config;

variable START_COLLECTL_AS_SERVICE ?= true;
"/software/components/chkconfig/service/collectl/" = {
    if (START_COLLECTL_AS_SERVICE) {
        onoroff='on';
    } else {
        onoroff='off';
    };
    dict(onoroff, "", "startstop", true);
};

include 'components/metaconfig/config';
include 'metaconfig/collectl/config';

prefix "/software/components/metaconfig/services/{/etc/collectl.conf}";
"daemons" =  {if (START_COLLECTL_AS_SERVICE) { SELF } else { null }};

variable COLLECTL_DAEMONMETRICS ?= '-s+YZ';
variable COLLECTL_DAEMONOTHEROPTS ?= '';
variable COLLECTL_GRAPHITE_CARBON_SERVER ?= undef; # needs to be the plaintext port
variable COLLECTL_GRAPHITE_CARBON_OPTS ?= '';
variable COLLECTL_GRAPHITE ?= false;

variable COLLECTL_DAEMONCOMMANDS ?= {
    if(COLLECTL_GRAPHITE) {
        format('--export graphite,%s%s %s %s', COLLECTL_GRAPHITE_CARBON_SERVER, COLLECTL_GRAPHITE_CARBON_OPTS, COLLECTL_DAEMONMETRICS, COLLECTL_DAEMONOTHEROPTS);
    } else {
        format('-f /var/log/collectl -r00:00,7 -m -F60 %s %s', COLLECTL_DAEMONMETRICS, COLLECTL_DAEMONOTHEROPTS);
    };
};
prefix "/software/components/metaconfig/services/{/etc/collectl.conf}/contents/main";
"DaemonCommands" = COLLECTL_DAEMONCOMMANDS;
