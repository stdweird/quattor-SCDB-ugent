# Template defining all the MW components required to use Torque/MAUI as LRMS

unique template common/torque2/server/service;

## no +RPM_BASE_FLAVOUR
include { 'common/torque2/server/packages' };

include { 'common/torque2/server/config' };

# This should eventually be split out to allow users to choose different
# schedulers.
variable TORQUE_USE_MAUI ?= true;
variable MAUI_IS_MAUI ?= "maui";

include {
    if(TORQUE_USE_MAUI) {
        format("common/%s/server/service",MAUI_IS_MAUI);
    }
};
include {
    if(TORQUE_USE_MAUI) {
        format("common/%s/client/service",MAUI_IS_MAUI);
    }
};

include {if_exists('site/backup')};

include {'common/torque2/server/logstash'};
