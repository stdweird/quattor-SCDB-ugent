unique template common/nagios/checks/gpfs;

'/software/packages/{perl-Proc-Background}' = nlist();

## additional symlinks for script to work?
"/software/components/symlink/links" =
        push(nlist(
                "name", CHECKS_LOCATION+"restricted/mmgetstate",
                "target", CHECKS_LOCATION + "gpfscheck",
                "replace", nlist("all","yes"),
                )
        );



variable SCRIPT_NAME = "check_gpfs.pl";
variable CHECK_NAME = "check_gpfs_status";

'/software/components/nrpe/options/command' = npush(CHECK_NAME,format("sudo %s/restricted/%s status",CHECKS_LOCATION,SCRIPT_NAME));

"/software/components/symlink/links" =
        push(nlist(
                "name", CHECKS_LOCATION+"restricted/"+SCRIPT_NAME,
                "target", CHECKS_LOCATION+SCRIPT_NAME,
                "replace", nlist("all","yes"),
                )
        );
