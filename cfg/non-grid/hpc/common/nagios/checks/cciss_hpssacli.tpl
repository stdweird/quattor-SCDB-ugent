unique template common/nagios/checks/cciss_hpssacli;


# add hp tools for raid check
prefix "/software/packages";
"{hpssacli}" = nlist();

'/software/components/nrpe/options/command/check_cciss_hpssacli' = format("%s/hpc/check_cciss_hpssacli.sh -v", CHECKS_NAGIOS_DEF);

include 'components/sudo/config';

"/software/components/sudo/privilege_lines" = append(
        nlist("cmd", "/usr/sbin/hpssacli* controller *show*",
              "user", "nagios",
              "run_as", "ALL",
              "host", "ALL",
              "options", "NOPASSWD:"));
