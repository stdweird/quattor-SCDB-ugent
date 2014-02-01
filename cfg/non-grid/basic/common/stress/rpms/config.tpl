unique template common/stress/rpms/config;

## add some testing rpms 
## stresslinux http://download.obs.j0ke.net/stresslinux/standard/src/
"/software/packages"=pkg_repl("memtester","4.1.2-1.1","x86_64");
"/software/packages"=pkg_repl("cpuburn","1.4-4.13","x86_64");

