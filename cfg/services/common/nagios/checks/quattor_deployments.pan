unique template common/nagios/checks/quattor_deployments;

variable PROC_NAME = "ncm-cdispd";


'/software/components/nrpe/options/command' = {
        SELF["check_cdispd"] = format("%s/check_procs -c 1 -C %s",
                                      CHECKS_NAGIOS_DEF, PROC_NAME);
        SELF["check_quattor_update_id"] = format("%s/hpc/check_quattor_update_id.py",
                                                 CHECKS_NAGIOS_DEF);

        SELF["check_ncd"] = format("sudo %s/hpc/restricted/check_ncd.py", CHECKS_NAGIOS_DEF);
        SELF["check_ccm"] = format("sudo %s/hpc/restricted/check_ccm_status.py", CHECKS_NAGIOS_DEF);
        SELF;
};

include 'components/sudo/config';

"/software/components/sudo/privilege_lines" = append(
        dict("cmd", "/usr/sbin/ncm-query /system/quattorid",
              "user", value("/software/components/nrpe/options/nrpe_user"),
              "run_as", "ALL",
              "host", "ALL",
              "options", "NOPASSWD:"));

"/software/components/symlink/links" = {
    foreach (i; check; list("check_ncd.py", "check_ccm_status.py", "check_quattor_update_id.py", "check_quattorid_cluster.py")) {
        append(dict(
                "name", format("%s/restricted/%s", CHECKS_LOCATION, check),
                "target", format("%s/%s", CHECKS_LOCATION, check),
                "replace", dict("all","yes")));
    };
};
