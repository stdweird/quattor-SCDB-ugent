unique template common/nagios/checks/check_gpfs_devices;

variable CHECK_NAME = "check_gpfs_devices";
variable SCRIPT_NAME = CHECK_NAME + '.py';

#"/software/components/filecopy/services" = copy_file(
#    CHECKS_LOCATION+SCRIPT_NAME,
#    CHECKS_INCL+"files/"+SCRIPT_NAME,
#    0);

'/software/components/nrpe/options/command' = npush(CHECK_NAME,CHECKS_LOCATION+"restricted/"+SCRIPT_NAME);

"/software/components/symlink/links" =
        push(dict(
                "name", CHECKS_LOCATION+"restricted/"+SCRIPT_NAME,
                "target", CHECKS_LOCATION+SCRIPT_NAME,
                "replace", dict("all","yes"),
                )
        );
