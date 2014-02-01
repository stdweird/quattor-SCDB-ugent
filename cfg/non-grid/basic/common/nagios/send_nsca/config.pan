unique template common/nagios/send_nsca/config;

variable NAGIOS_SEND_NSCA_PASSWORD ?= undef;
variable NAGIOS_SEND_NSCA_ENCRYPTION ?= 1;

include {'common/nagios/send_nsca/schema'};
bind "/software/components/metaconfig/services/{/etc/nagios/send_nsca.cfg}/contents" = nagios_send_nsca;

prefix "/software/components/metaconfig/services/{/etc/nagios/send_nsca.cfg}";
"mode" = 0600; # file contains password-like string
"owner" = "root";
"group" = "root";
"module" = "tiny";

prefix "/software/components/metaconfig/services/{/etc/nagios/send_nsca.cfg}/contents";
"password" = NAGIOS_SEND_NSCA_PASSWORD;
"encryption_method" = NAGIOS_SEND_NSCA_ENCRYPTION;
