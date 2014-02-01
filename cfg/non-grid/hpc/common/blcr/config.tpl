unique template common/blcr/config;

# disable auditd service
# needs extra reboot
prefix "/software/components/chkconfig/service";
"auditd" = nlist('off','','startstop',true);
"blcr" = nlist("on","","startstop",true);

