unique template common/nat/monitoring;

include 'components/nrpe/config';

prefix "/software/components/nrpe/options/command";

"check_shorewall" = "/usr/lib64/nagios/plugins/hpc/check_shorewall.sh";
"check_ipmi_dell" = format("/usr/lib64/nagios/plugins/hpc/check_ipmitool.pl --ip=$ARG1$ --user=root --pwd='%s'", IPMI_PASSWD);
"check_ipmi_hp" = format("/usr/lib64/nagios/plugins/hpc/check_ipmitool.pl --ip=$ARG1$ --user=admin --pwd='%s'", IPMI_PASSWD);
"check_openvpn" = "/usr/lib64/nagios/plugins/check_procs -c 1:1 -C openvpn";
"check_procs_ptpd" = "/usr/lib64/nagios/plugins/check_procs -c 1:3 -C ptpd2";
"check_p2000_disks" = '/usr/lib64/nagios/plugins/hpc/count-disks.py -H "$ARG1$" -c /etc/p2k.cfg';

# required for check_shorewall.sh. TODO rewrite check and add teh statsu check to sudoers
"/software/components/symlink/links" =
        push(dict(
                "name", "/usr/lib64/nagios/plugins/hpc/restricted/shorewall",
                "target", "/etc/init.d/shorewall",
                "replace", dict("all","yes"),
                )
        );
