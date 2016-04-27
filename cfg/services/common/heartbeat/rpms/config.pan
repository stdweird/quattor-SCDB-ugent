unique template common/heartbeat/rpms/config;

variable HB_VERSION_MAJOR = "2.1.3";
variable HB_VERSION_MINOR = "-3.el5.centos";

variable PKG_ARCH_HEARTBEAT ?= PKG_ARCH_DEFAULT;


# Add RPM
"/software/packages"=pkg_repl("heartbeat",HB_VERSION_MAJOR+HB_VERSION_MINOR,PKG_ARCH_HEARTBEAT);
"/software/packages"=pkg_repl("heartbeat-pils",HB_VERSION_MAJOR+HB_VERSION_MINOR,PKG_ARCH_HEARTBEAT);
#"/software/packages"=pkg_repl("heartbeat-ldirectord",HB_VERSION_MAJOR+HB_VERSION_MINOR,PKG_ARCH_HEARTBEAT);
"/software/packages"=pkg_repl("heartbeat-gui",HB_VERSION_MAJOR+HB_VERSION_MINOR,PKG_ARCH_HEARTBEAT);

"/software/packages"=pkg_repl("heartbeat-stonith",HB_VERSION_MAJOR+HB_VERSION_MINOR,PKG_ARCH_HEARTBEAT);

"/software/packages"=pkg_repl("heartbeat-devel",HB_VERSION_MAJOR+HB_VERSION_MINOR,PKG_ARCH_HEARTBEAT);
