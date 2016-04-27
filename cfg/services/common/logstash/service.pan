unique template common/logstash/service;

include 'components/accounts/config';
include 'common/logstash/config';
include 'components/chkconfig/config';
include 'common/logstash/packages';

"/software/components/chkconfig/service/logstash" = dict(
    "on", "",
    "startstop", true);

"/software/components/chkconfig/dependencies/pre" = {
    append("accounts");
    if (exists("/software/components/authconfig")) {
	   append("authconfig");
    };
    SELF;
};

include 'common/nagios/checks/logstash';

prefix "/software/components/accounts/users/logstash";

"comment" = "Logstash user";
"uid" =  591;
"createHome" = true;
"homeDir" = "/var/lib/logstash";
"shell" = "/sbin/nologin";
"groups/0" = "logstash";

# add ccmcert as group to give beats plugin access to the key
"/software/components/accounts/users/logstash/groups" = append("ccmcert");


"/software/components/accounts/groups/logstash/gid" = 591;
