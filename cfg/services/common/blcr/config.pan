unique template common/blcr/config;

# disable auditd service
# needs extra reboot
prefix "/software/components/chkconfig/service";
"auditd" = dict('off','','startstop',true);
"blcr" = dict("on","","startstop",true);
