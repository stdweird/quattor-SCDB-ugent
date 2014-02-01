unique template common/kdc/monitoring;


"/software/components/nrpe/options/command/check_procs_kdc" =
        "/usr/lib64/nagios/plugins/check_procs -c 1:1 -C krb5kdc";

"/system/monitoring/hostgroups" = append("kdc");
