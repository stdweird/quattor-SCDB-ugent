unique template common/moab/server/unit;

# moab unit tuning

prefix "/software/components/systemd/unit/moab/file";
"only" = true; # chkconfig is still used
"replace" = false;
# wait for pbs_server is started, implies pbs_server is running on the same node
"config/unit" = dict(
    "After", list("pbs_server.service"),
    "Requires", list("network.target", "pbs_server.service"),
    );
"config/service" = dict(
    "TimeoutStartSec", 600, # moab slow start
    "TimeoutStopSec", 300,
    );
