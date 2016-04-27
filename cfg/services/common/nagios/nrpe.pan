unique template common/nagios/nrpe;

include 'components/nrpe/config';

"/software/components/chkconfig/service/nrpe" = dict("on", "", "startstop", true);

# OS specific settings
include if_exists('dict/nrpe');

# Set a default user if nothing is set
'/software/components/nrpe/options/nrpe_user' ?= 'nagios';

# add nrpe config
include 'monitoring/nagios/nrpe/config';

# add nrpe checks + commands
include 'common/nagios/checks/checks';

prefix '/software/components/nrpe/options/';
'dont_blame_nrpe' = true;
'nrpe_group' ?= value("/software/components/nrpe/options/nrpe_user");

# sudo settings
#    user    host = (run_as_user) OPTIONS: command

include 'common/sudo/config';
"/software/components/sudo/privilege_lines" = {
    append(dict(
        "user", value("/software/components/nrpe/options/nrpe_user"),
        "run_as", "ALL",
        "host", "ALL",
        "cmd", CHECKS_LOCATION + "restricted/",
        "options", "NOPASSWD:"
        ));
    append(dict(
        "user", value("/software/components/nrpe/options/nrpe_user"),
        "run_as", "ALL",
        "host", "ALL",
        "cmd", "/usr/sbin/dmidecode",
        "options", "NOPASSWD:"
        ));
};

"/software/components/nrpe/dependencies/pre" = append("accounts");

"/software/components/accounts/" = {
    SELF['kept_users'][value("/software/components/nrpe/options/nrpe_user")] = "";
    SELF['kept_groups'][value("/software/components/nrpe/options/nrpe_group")] = "";
    SELF;
};

# add directory for any cache files for nagios checks
prefix "/software/components/dirperm";
"paths" = append(dict(
   "path", "/var/cache/icinga",
   "owner", format("%s:%s", value("/software/components/nrpe/options/nrpe_user"), value("/software/components/nrpe/options/nrpe_group")),
   "perm", "0750",
   "type", "d",
   ));
