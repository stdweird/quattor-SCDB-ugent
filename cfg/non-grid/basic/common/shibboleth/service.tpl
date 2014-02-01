unique template common/shibboleth/service;

include { "common/shibboleth/packages" };

include { 'common/shibboleth/config' };

# Start shibd
include { 'components/chkconfig/config' };
"/software/components/chkconfig/service/shibd/on" = "";
"/software/components/chkconfig/service/shibd/startstop" = true;
