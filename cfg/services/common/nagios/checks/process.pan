unique template common/nagios/checks/process;


variable PROC_NAME = "pbs_mom";
"/software/components/symlink/links" =
        push(dict(
                "name", CHECKS_LOCATION+"restricted/"+PROC_NAME,
                "target", "/etc/init.d/"+PROC_NAME,
                "replace", dict("all","yes"),
                )
        );

'/software/components/nrpe/options/command' = npush("check_procs_"+PROC_NAME,CHECKS_NAGIOS_DEF+"check_procs -c 1:10 -C "+PROC_NAME);


## rsync daemon
variable PROC_NAME = "rsync";
'/software/components/nrpe/options/command' = npush("check_procs_"+PROC_NAME,CHECKS_NAGIOS_DEF+"check_procs -c 1:25 -w 1:5 -C "+PROC_NAME);

## goldProxy daemon
variable PROC_NAME = "goldProxy";
'/software/components/nrpe/options/command' = npush("check_procs_"+PROC_NAME,CHECKS_NAGIOS_DEF+"check_procs -c 1:25 -w 1:5 -a "+PROC_NAME);

## nscd daemon
variable PROC_NAME = "nscd";
'/software/components/nrpe/options/command' = npush("check_procs_"+PROC_NAME,CHECKS_NAGIOS_DEF+"check_procs -c 1:25 -w 1:5 -a "+PROC_NAME);

'/software/components/nrpe/options/command' = {
    SELF['check_openvpn'] = format("%s/check_procs -c4 -C %s",
                                    CHECKS_NAGIOS_DEF, 'openvpn');
    SELF['check_procs_elasticsearch'] = format("%s/check_procs -c1:1 -a %s -C %s",
                                                CHECKS_NAGIOS_DEF, 'elasticsearch', 'java');
    SELF['check_procs_graylog2'] = format("%s/check_procs -c1:1 -a %s -C %s",
                                           CHECKS_NAGIOS_DEF, 'graylog2', 'java');
    SELF['check_procs_httpd'] = format("%s/check_procs -C %s",
                                        CHECKS_NAGIOS_DEF, 'httpd');
    SELF['check_procs_java'] = format("%s/check_procs -C %s",
                                      CHECKS_NAGIOS_DEF, 'java');
    SELF['check_procs_logstash'] = format("%s/check_procs -c1:1 -a %s -C %s",
                                            CHECKS_NAGIOS_DEF, 'logstash', 'java');
    SELF['check_procs_logstash-forwarder'] = format("%s/check_procs -c1:1 -a %s",
                                                    CHECKS_NAGIOS_DEF, 'logstash-forwarder');
    SELF['check_procs_filebeat'] = format("%s/check_procs -c1:2 -a %s",
                                          CHECKS_NAGIOS_DEF, 'filebeat');
    SELF['check_procs_topbeat'] = format("%s/check_procs -c1:2 -a %s",
                                         CHECKS_NAGIOS_DEF, 'topbeat');
    SELF['check_procs_oned'] = format("%s/check_procs -c1:1 -C %s",
                                                    CHECKS_NAGIOS_DEF, 'oned');
    SELF['check_procs_sunstone'] = format("%s/check_procs -c1:1 -C ruby -a %s",
                                                    CHECKS_NAGIOS_DEF, 'sunstone-server');
    SELF['check_procs_onegate'] = format("%s/check_procs -c1:1 -C ruby -a %s",
                                                    CHECKS_NAGIOS_DEF, 'onegate-server');
    SELF['check_procs_oneflow'] = format("%s/check_procs -c1:1 -C ruby -a %s",
                                                    CHECKS_NAGIOS_DEF, 'oneflow-server');
    SELF['check_procs_passenger'] = format("%s/check_procs -C %s",
                                                    CHECKS_NAGIOS_DEF, 'passenger');
    SELF['check_procs_memcached'] = format("%s/check_procs -C %s",
                                                    CHECKS_NAGIOS_DEF, 'memcached');
    SELF['check_procs_libvirtd'] = format("%s/check_procs -c1:1 -C %s",
                                                    CHECKS_NAGIOS_DEF, 'libvirtd');
    SELF['check_procs_mysql'] = format("%s/check_procs -C %s",
                                                    CHECKS_NAGIOS_DEF, 'mysqld');
    SELF['check_procs_mongod'] = format("%s/check_procs -c 1 -C %s",
                                        CHECKS_NAGIOS_DEF, 'mongod');
    SELF['check_procs_named'] = format("%s/check_procs -c 1 -C %s",
                                        CHECKS_NAGIOS_DEF, 'named');
    SELF['check_procs_postgres'] = format("%s/check_procs -C %s",
                                        CHECKS_NAGIOS_DEF, 'postmaster');
    SELF['check_procs_pbsacc2db'] = format("%s/check_procs -c 1:1 -C python -a %s",
                                        CHECKS_NAGIOS_DEF, 'pbsacc2db');
    SELF['check_procs_sssd'] = format("%s/check_procs -c 1 -C %s",
                                        CHECKS_NAGIOS_DEF, 'sssd');
    SELF['check_procs_syslog'] = format("%s/check_procs -c 1 -a %s",
                                        CHECKS_NAGIOS_DEF, 'syslog');
    SELF['check_procs_trqauthd'] = format("%s/check_procs -c 1 -C %s",
                                        CHECKS_NAGIOS_DEF, 'trqauthd');
    SELF;
};
