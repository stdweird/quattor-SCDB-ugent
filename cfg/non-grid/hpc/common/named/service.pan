unique template common/named/service;

include 'common/named/packages';

include {'common/named/config'};
include 'common/named/monitoring';

"/software/packages/{named-hpcugent}" = nlist();
