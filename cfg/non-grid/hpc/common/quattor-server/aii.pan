unique template common/quattor-server/aii;

include 'common/httpd/schema';

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
"daemon/0" = "httpd";

"contents/aliases" = list();
"contents/modules" = list();


include 'components/aiiserver/config';

prefix "/software/components/aiiserver/aii-shellfe";

# File URL here for speed!!
"cdburl" = "file:///var/www/https/profiles";

"cert_file" = value("/software/components/ccm/cert_file");
"key_file" = value("/software/components/ccm/key_file");
"ca_file" = value("/software/components/ccm/ca_file");
"profile_format"="json.gz";
"use_fqdn" = true;

"/software/components/aiiserver/aii-dhcp" = nlist();

prefix "/software/packages";

"{aii-server}" = nlist();
"{aii-pxelinux}" = nlist();
"{aii-ks}" = nlist();
"{ncm-lib-blockdevices}" = nlist();
"{cdb-sync}" = nlist();
"{aii_sindes}" = nlist();
"{dhcp}" = nlist();
"{tftp-server}" = nlist();

include 'components/sudo/config';

"/software/components/sudo/privilege_lines" = append(
    nlist("cmd", "/usr/sbin/aii-shellfe --boot *",
          "options", "NOPASSWD:",
          "host", "ALL",
          "run_as", "ALL",
          "user", "apache"));

include 'components/sysconfig/config';

"/software/components/sysconfig/files/dhcpd/DHCPDARGS" = "'-cf /etc/dhcpd.conf'";

include 'components/chkconfig/config';

prefix "/software/components/chkconfig";
"service/dhcpd" = nlist("on", "", "startstop", true);
"dependencies/pre" = append("sysconfig");

variable XINETD_SERVICES_TFTP = true;
include 'common/xinetd/config';
"/software/components/metaconfig/services/{/etc/xinetd.d/tftp}/contents/options/server_args" = "-c -s -v -v -v /osinstall/nbp";
