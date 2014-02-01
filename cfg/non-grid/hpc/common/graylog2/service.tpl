unique template common/graylog2/service;

include {'components/accounts/config'};
include {'common/graylog2/schema'};
include {'common/graylog2/config'};

"/software/packages" = pkg_repl("graylog2", "0.9.6-1.el6", PKG_ARCH_DEFAULT);
"/software/packages" = pkg_repl("perl-Config-Tiny", "2.12-7.1.el6","noarch");
"/software/packages" = pkg_repl("graylog-drools", "0.1-1.el6", PKG_ARCH_DEFAULT);

include {'common/mongodb/service'};

"/software/components/chkconfig/service/graylog2" = nlist(
    "on", "",
    "startstop", true);

"/system/monitoring/hostgroups" = append("graylog2");

include {'common/nagios/checks/graylog2'};
