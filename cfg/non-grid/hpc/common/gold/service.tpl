unique template common/gold/service;

include { 'common/gold/packages' };

include { 'common/gold/config' };

include { 'components/chkconfig/config' };
"/software/components/chkconfig/service/gold/on" = "";
"/software/components/chkconfig/service/gold/startstop" = true;


"/system/monitoring/hostgroups" = {
    append(SELF, "gold_servers");
    SELF;
};

