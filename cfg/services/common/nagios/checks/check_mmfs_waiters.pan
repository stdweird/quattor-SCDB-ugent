unique template common/nagios/checks/check_mmfs_waiters;

variable CHECK_NAME = "check_gpfs_mmfsadm_waiters";
variable SCRIPT_NAME = CHECK_NAME;

#"/software/components/filecopy/services" = copy_file(
#    CHECKS_LOCATION+SCRIPT_NAME,
#    CHECKS_INCL+"files/"+SCRIPT_NAME,
#    0);

'/software/components/nrpe/options/command' = npush(CHECK_NAME,
    format("%s/%s -w", CHECKS_LOCATION, SCRIPT_NAME));
"/software/components/symlink/links" = {
    dst = "mmfsadm";
    append(dict(
            "name", format("%s/restricted/%s", CHECKS_LOCATION, dst),
            "target", "/usr/lpp/mmfs/bin/mmfsadm",
            "replace", dict("all","yes"),
	)
    );
};
