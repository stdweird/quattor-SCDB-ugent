unique template common/nagios/checks/show;


variable CHECK_SHOW = "jobs";
variable CHECK_NAME = "show_"+CHECK_SHOW;
variable SCRIPT_NAME = CHECK_NAME+"";

#"/software/components/filecopy/services" = copy_file(
#    CHECKS_LOCATION+SCRIPT_NAME,
#    CHECKS_INCL+"files/"+SCRIPT_NAME,
#    0);

"/software/components/symlink/links" =
        push(nlist(
                "name", CHECKS_LOCATION+"restricted/"+SCRIPT_NAME,
                "target", CHECKS_LOCATION+SCRIPT_NAME,
                "replace", nlist("all","yes"),
                )
        );
'/software/components/nrpe/options/command' = npush("check_"+CHECK_NAME,"sudo "+CHECKS_LOCATION+SCRIPT_NAME);


variable CHECK_SHOW = "nodes";
variable CHECK_NAME = "show_"+CHECK_SHOW;
variable SCRIPT_NAME = CHECK_NAME+"";

#"/software/components/filecopy/services" = copy_file(
#    CHECKS_LOCATION+SCRIPT_NAME,
#    CHECKS_INCL+"files/"+SCRIPT_NAME,
#    0);

"/software/components/symlink/links" =
        push(nlist(
                "name", CHECKS_LOCATION+"restricted/"+SCRIPT_NAME,
                "target", CHECKS_LOCATION+SCRIPT_NAME,
                "replace", nlist("all","yes"),
                )
        );
'/software/components/nrpe/options/command' = npush("check_"+CHECK_NAME,"sudo "+CHECKS_LOCATION+SCRIPT_NAME);
'/software/components/nrpe/options/command' = npush("check_"+CHECK_NAME+"_all","sudo "+CHECKS_LOCATION+SCRIPT_NAME+" master");



variable CHECK_SHOW = "moab_nodes";
variable CHECK_NAME = "show_"+CHECK_SHOW;
variable SCRIPT_NAME = CHECK_NAME+"";

#"/software/components/filecopy/services" = copy_file(
#    CHECKS_LOCATION+SCRIPT_NAME,
#    CHECKS_INCL+"files/"+SCRIPT_NAME,
#    0);

"/software/components/symlink/links" =
        push(nlist(
                "name", CHECKS_LOCATION+"restricted/"+SCRIPT_NAME,
                "target", CHECKS_LOCATION+SCRIPT_NAME,
                "replace", nlist("all","yes"),
                )
        );
'/software/components/nrpe/options/command' = npush("check_"+CHECK_NAME,"sudo "+CHECKS_LOCATION+SCRIPT_NAME);
'/software/components/nrpe/options/command' = npush("check_"+CHECK_NAME+"_all","sudo "+CHECKS_LOCATION+SCRIPT_NAME+" master");
