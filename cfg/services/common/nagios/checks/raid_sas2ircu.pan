unique template common/nagios/checks/raid_sas2ircu;

variable CHECK_NAME = "raid_sas2ircu";
variable SCRIPT_NAME = CHECK_NAME+".py";
      
'/software/components/nrpe/options/command' = npush("check_"+CHECK_NAME,"sudo "+CHECKS_LOCATION+"restricted/"+CHECK_NAME + " --nagios");

"/software/components/symlink/links" =
        push(dict(
                "name", CHECKS_LOCATION+"restricted/"+CHECK_NAME,
                "target", CHECKS_LOCATION+"check_"+SCRIPT_NAME,
                "replace", dict("all","yes"),
                )
        );
