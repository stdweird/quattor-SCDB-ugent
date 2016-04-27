unique template common/nagios/checks/cpu;

variable CHECK_NAME = "check_cpu_stats";
variable SCRIPT_NAME = CHECK_NAME+".sh";

#"/software/components/filecopy/services" = copy_file(
#    CHECKS_LOCATION+SCRIPT_NAME,
#    CHECKS_INCL+"files/"+SCRIPT_NAME,
#    0);

# user, sys, iowait
variable NAGIOS_CHECK_CPU_WARN ?= list(101,30,30);
variable NAGIOS_CHECK_CPU_CRIT ?= list(102,90,90);
        
'/software/components/nrpe/options/command' = npush(
    CHECK_NAME,format("%s%s -w %d,%d,%d -c %d,%d,%d",
                      CHECKS_LOCATION,SCRIPT_NAME,
                      NAGIOS_CHECK_CPU_WARN[0],NAGIOS_CHECK_CPU_WARN[1],NAGIOS_CHECK_CPU_WARN[1],
                      NAGIOS_CHECK_CPU_CRIT[0],NAGIOS_CHECK_CPU_CRIT[1],NAGIOS_CHECK_CPU_CRIT[1]));
