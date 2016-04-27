unique template common/cgroups/config;

# create cpuset device on startup
prefix "/software/components/chkconfig/service";
"cgred" = dict("on", "", "startstop", true);
"cgconfig" = dict("on", "", "startstop", true);
