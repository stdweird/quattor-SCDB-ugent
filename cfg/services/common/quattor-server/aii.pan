unique template common/quattor-server/aii;

include 'metaconfig/httpd/schema';

bind "/software/components/metaconfig/services/{/etc/httpd/conf.d/aii-ks.conf}/contents" = httpd_vhosts;

include 'common/httpd/service';

# nothing on default vhost on port 443, just remove it
"/software/components/metaconfig/services/{/etc/httpd/conf.d/ssl.conf}/contents/vhosts/base" = null;

prefix "/software/components/metaconfig/services/{/etc/httpd/conf.d/aii-ks.conf}/contents/vhosts";

"ks" = create("common/httpd/struct/default_vhost",
    "documentroot", "/var/www/http",
    "port", 80);
"ks/ssl" = null;



prefix "/software/components/metaconfig/services/{/etc/httpd/conf.d/aii-ks.conf}";

"module" = "httpd/generic_server";
"daemons" = dict("httpd", "restart");

"contents/aliases" = list();
"contents/modules" = list();


include 'components/aiiserver/config';

prefix "/software/components/aiiserver/aii-shellfe";

# File URL here for speed!!
"cdburl" = "file:///var/www/https/profiles";

"profile_format"="json.gz";
"use_fqdn" = true;

"/software/components/aiiserver/aii-dhcp" = dict();

prefix "/software/packages";

"{aii_sindes}" = dict();
"{dhcp}" = dict();
"{tftp-server}" = dict();

include 'components/sudo/config';

"/software/components/sudo/privilege_lines" = append(
    dict("cmd", "/usr/sbin/aii-shellfe --boot *",
          "options", "NOPASSWD:",
          "host", "ALL",
          "run_as", "ALL",
          "user", "apache"));

include 'components/sysconfig/config';

"/software/components/sysconfig/files/dhcpd/DHCPDARGS" = "'-cf /etc/dhcpd.conf'";

include 'components/chkconfig/config';

prefix "/software/components/chkconfig";
"service/dhcpd" = dict("on", "", "startstop", true);
"dependencies/pre" = append("sysconfig");

variable XINETD_SERVICES_TFTP = true;
include 'common/xinetd/config';
"/software/components/metaconfig/services/{/etc/xinetd.d/tftp}/contents/options/server_args" = "-c -s -v -v -v /osinstall/nbp";
