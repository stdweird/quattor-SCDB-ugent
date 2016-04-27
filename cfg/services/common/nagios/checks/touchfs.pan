unique template common/nagios/checks/touchfs;

variable CHECK_NAME = "check_touchfs";
variable SCRIPT_NAME = CHECK_NAME;
      
'/software/components/nrpe/options/command' = npush(CHECK_NAME,"sudo "+CHECKS_LOCATION+"restricted/"+CHECK_NAME + " -t gpfs -t binfmt_misc -t cpuset -t ipathfs -t cgroup -t configfs -t pstore -t autofs -t nfs -t nfs4 -x /proc/sys/fs/binfmt_misc");

"/software/components/symlink/links" =
        push(dict(
                "name", CHECKS_LOCATION+"restricted/"+CHECK_NAME,
                "target", CHECKS_LOCATION+SCRIPT_NAME,
                "replace", dict("all","yes"),
                )
        );
