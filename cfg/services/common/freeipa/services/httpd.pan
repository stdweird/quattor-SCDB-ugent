unique template common/freeipa/services/httpd;

prefix "/software/packages";
"{mod_auth_kerb}" = dict();
"{mod_nss}" = dict();

# mod_auth_kerb writes a conf file that is mainly empty
# mod_nss writes a nss.conf file similar to ssl.conf
# it also sets up a nssdb under /etc/httpd/alias
