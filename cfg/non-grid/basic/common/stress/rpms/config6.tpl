unique template common/stress/rpms/config6;

## add some testing rpms
## from stresslinux http://download.obs.j0ke.net/stresslinux/standard/src/
"/software/packages"=pkg_repl("memtester","4.2.1-1."+RPM_BASE_FLAVOUR_NAME,"x86_64");
"/software/packages"=pkg_repl("cpuburn","1.4-4.13","x86_64");

