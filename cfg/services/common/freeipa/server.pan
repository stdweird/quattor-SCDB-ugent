unique template common/freeipa/server;

prefix "/software/packages";
"{ipa-server}" = dict();
"{bind-dyndb-ldap}" = dict();
"{java-1.7.0-openjdk}" = dict(); 

include 'site/backup';

include 'common/kdc/monitoring';
