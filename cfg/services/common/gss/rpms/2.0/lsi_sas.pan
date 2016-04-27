unique template common/gss/rpms/2.0/lsi_sas;

variable OS_REPOSITORY_LIST = append("gss/lsi_sas");

#"/software/packages" = pkg_repl("kmod-mpt2sas","18.00.01.00_rhel6.5-1","x86_64");
"/software/packages" = pkg_repl("mpt2sas","18.00.01.00-1dkms", "noarch");
