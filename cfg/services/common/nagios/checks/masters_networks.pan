unique template common/nagios/checks/masters_networks;

variable SCRIPT_NAME = "check_ping";

variable master_list = list("master1.gengar.gent.vsc" , "master2.gengar.gent.vsc" , "master3.gastly.gent.vsc" , "master5.haunter.gent.vsc" , "master9.gulpin.gent.vsc", "master11.dugtrio.gent.vsc");

'/software/components/nrpe/options/command' = {
    foreach (i; v; master_list) {        
        SELF["check_nrpe_conn2"+v]=CHECKS_NAGIOS_DEF+SCRIPT_NAME+"  -H " + v + "  -w 100,20% -c 500,50%";
    };

    SELF;
};
