unique template common/cpuset/config;

# create cpuset device on startup
"/software/components/chkconfig/service/cpuset" = nlist("on", "", "startstop", true);

