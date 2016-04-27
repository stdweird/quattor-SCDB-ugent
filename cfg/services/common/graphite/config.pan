unique template common/graphite/config;
include 'components/sysconfig/config';
"/software/components/sysconfig/files/carbon" = dict(
    "prologue",format("ulimit -n %d",4096),
);
