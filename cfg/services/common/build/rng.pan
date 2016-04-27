unique template common/build/rng;

"/software/packages/{rng-tools}" = dict();

include 'components/sysconfig/config';
"/software/components/sysconfig/files/rngd" = dict(
    'EXTRAOPTIONS', '"-o /dev/random -r /dev/urandom -W 2048"',
);

"/software/components/chkconfig/service/rngd" = dict("on", "", "startstop", true);
