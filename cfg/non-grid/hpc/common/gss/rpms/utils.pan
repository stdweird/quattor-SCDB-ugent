unique template common/gss/rpms/utils;

variable OS_REPOSITORY_LIST = append("gss/utils");

"/software/packages" = pkg_repl("gss.firmware", "0.1-0", "x86_64");

"/software/packages" = pkg_repl("ibm-driver-tools", "0.140-0", "noarch");
"/software/packages" = pkg_repl("Lib_Utils", "1.00-09", "noarch");
"/software/packages" = pkg_repl("MegaCli", "8.04.08-1", "noarch");
"/software/packages" = pkg_repl("ibm_utl_asu", "9.30-asut79N", "x86_64");

prefix "/software/packages";
"{iozone}" = nlist();    
"{iperf}" = nlist();
