unique template common/elasticsearch/monitoring/nrpe;

include 'common/nagios/nrpe';

prefix "/software/components/nrpe/options/command";

"check_free_mountpoints" = format("%s/%s -w 5 -c 10 %s",
    CHECKS_NAGIOS_DEF, "check_disk",
    value("/software/components/accounts/users/elasticsearch/homeDir"));
