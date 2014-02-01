unique template common/maui/server/rpms/config;

variable PKG_ARCH_TORQUE_MAUI ?= PKG_ARCH_DEFAULT;

# Base RPMs
variable MAUI_RPM_VERSION ?= '3.3.1-1.sl5.ug7';

'/software/packages'=pkg_repl('maui',MAUI_RPM_VERSION,PKG_ARCH_TORQUE_MAUI);
'/software/packages'=pkg_repl('maui-client',MAUI_RPM_VERSION,PKG_ARCH_TORQUE_MAUI);
'/software/packages'=pkg_repl('maui-devel',MAUI_RPM_VERSION,PKG_ARCH_TORQUE_MAUI);
'/software/packages'=pkg_repl('maui-server',MAUI_RPM_VERSION,PKG_ARCH_TORQUE_MAUI);




