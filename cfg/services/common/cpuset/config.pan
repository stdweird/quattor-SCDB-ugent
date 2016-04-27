unique template common/cpuset/config;

# create cpuset device on startup
"/software/components/chkconfig/service/cpuset" = dict("on", "", "startstop", true);
