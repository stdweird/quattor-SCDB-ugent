unique template common/rsyslog/config;

include 'components/sysconfig/config';

"/software/components/sysconfig/files/rsyslog" = dict(
    "prologue",format("ulimit -n %d", 4096),
    "SYSLOGD_OPTIONS", '"-c 5"',
    );

