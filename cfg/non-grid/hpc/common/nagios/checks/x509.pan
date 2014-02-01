unique template common/nagios/checks/x509;

variable CHECK_NAME = "check_x509";
variable SCRIPT_NAME = CHECK_NAME+".sh";

'/software/components/nrpe/options/command' = npush(CHECK_NAME,CHECKS_LOCATION+SCRIPT_NAME + " -P $ARG1$ -w $ARG2$ -c $ARG3");
