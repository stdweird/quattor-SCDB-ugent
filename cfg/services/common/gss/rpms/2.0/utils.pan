unique template common/gss/rpms/2.0/utils;

variable OS_REPOSITORY_LIST = append("gss/utils");

"/software/packages" = pkg_repl("ibm-driver-tools", "0.140-0", "noarch");
"/software/packages" = pkg_repl("Lib_Utils", "1.00-09", "noarch");
"/software/packages" = pkg_repl("MegaCli", "8.04.10-1", "noarch");
"/software/packages" = pkg_repl("ibm_utl_asu", "9.52-asut83A", "x86_64");

prefix "/software/packages";
"{iozone}" = dict();    
"{iperf}" = dict();
