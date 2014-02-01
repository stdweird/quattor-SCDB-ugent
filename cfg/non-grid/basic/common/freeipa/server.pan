unique template common/freeipa/server;

prefix "/software/packages";
"{ipa-server}" = nlist();
"{bind-dyndb-ldap}" = nlist();
"{java-1.7.0-openjdk}" = nlist(); 

variable BACULA_FD = true;
include 'common/bacula/service';

include 'common/kdc/monitoring';