unique template common/pacemaker/rpms/config;

variable PKG_ARCH_PACEMAKER ?= PKG_ARCH_DEFAULT;

variable HB_VERSION_MAJOR = "2.1.3";
variable HB_VERSION_MINOR = "-3.el5.centos";


## rpms taken from http://www.clusterlabs.org/rpm/

variable CLUSTER_GLUE_VERSION ?= "1.0.1-1.el5";
"/software/packages"=pkg_repl("cluster-glue",CLUSTER_GLUE_VERSION,PKG_ARCH_PACEMAKER);
"/software/packages"=pkg_repl("cluster-glue-libs",CLUSTER_GLUE_VERSION,PKG_ARCH_PACEMAKER);
#"/software/packages"=pkg_repl("cluster-glue-libs-devel",CLUSTER_GLUE_VERSION,PKG_ARCH_PACEMAKER);
## deps
"/software/packages"=pkg_repl("openhpi-libs","2.14.0-5.el5",PKG_ARCH_PACEMAKER);
"/software/packages"=pkg_repl("perl-TimeDate","1.16-5.el5","noarch");


variable COROSYNC_VERSION ?= "1.1.2-1.el5";
"/software/packages"=pkg_repl("corosync",COROSYNC_VERSION,PKG_ARCH_PACEMAKER);
"/software/packages"=pkg_repl("corosynclib",COROSYNC_VERSION,PKG_ARCH_PACEMAKER);
#"/software/packages"=pkg_repl("corosynclib-devel",COROSYNC_VERSION,PKG_ARCH_PACEMAKER);
## deps
variable HAVE_OPENIB ?= false; 
include { if(HAVE_OPENIB) {return(null);} else {return('common/pacemaker/rpms/x86_64/openib')}; };

variable HEARTBEAT_VERSION ?= "3.0.1-1.el5";
"/software/packages"=pkg_repl("heartbeat",HEARTBEAT_VERSION,PKG_ARCH_PACEMAKER);
#"/software/packages"=pkg_repl("heartbeat-devel",HEARTBEAT_VERSION,PKG_ARCH_PACEMAKER);
"/software/packages"=pkg_repl("heartbeat-libs",HEARTBEAT_VERSION,PKG_ARCH_PACEMAKER);

#"/software/packages"=pkg_repl("ldirectord","1.0.1-1.el5",PKG_ARCH_PACEMAKER);

variable PACEMAKER_VERSION ?= "1.0.6-1.el5";
"/software/packages"=pkg_repl("pacemaker",PACEMAKER_VERSION,PKG_ARCH_PACEMAKER);
"/software/packages"=pkg_repl("pacemaker-libs",PACEMAKER_VERSION,PKG_ARCH_PACEMAKER);
#"/software/packages"=pkg_repl("pacemaker-libs-devel",PACEMAKER_VERSION,PKG_ARCH_PACEMAKER);
## deps
"/software/packages"=pkg_repl("libesmtp","1.0.4-5.el5",PKG_ARCH_PACEMAKER);

"/software/packages"=pkg_repl("resource-agents","1.0.1-1.el5",PKG_ARCH_PACEMAKER);
