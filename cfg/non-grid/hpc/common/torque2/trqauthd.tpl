unique template common/torque2/trqauthd;

## configure trqauthd 
## to be started on all torque 4.X nodes, required for all client tools
## daemon is part of torque-4.X rpm
## daemon binds to localhost, so no extra iptables entry needed


include { 'components/chkconfig/config' };
"/software/components/chkconfig/service/trqauthd" = nlist("on" , "","startstop" , true);

include { 'components/etcservices/config' };
"/software/components/etcservices/entries" = {
    append("trqauthd 15005/tcp");
    append("trqauthd 15005/udp");
};
