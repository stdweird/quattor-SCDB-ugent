unique template common/gss/rpms/1.5/lsi_sas;

variable OS_REPOSITORY_LIST = append("gss/lsi_sas");

"/software/packages" = pkg_repl("kmod-mpt2sas","15.00.00.00_rhel6.3-3","x86_64");
