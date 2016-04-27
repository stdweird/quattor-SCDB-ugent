unique template common/pacemaker/rpms/openib;


## deps for corosync
## these are sl5.4 default openib rpms
"/software/packages"=pkg_repl("librdmacm","1.0.8-5.el5","x86_64");
"/software/packages"=pkg_repl("libibverbs","1.1.2-4.el5","x86_64");
"/software/packages"=pkg_repl("openib","1.4.1-3.el5","noarch");
