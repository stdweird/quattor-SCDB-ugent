@{ Configure the logs for OpenLDAP.

OpenLDAP is horribly noisy.  We'll only send to the central storage
proof that a server is still running.  Everything else is stored
locally and kept for three days.

This allows us to store only 2% of the LDAP logs, which as of today
means 20% less resources (CPU and storage) dedicated to the global log
processing.
 @}

unique template common/openldap/config;
include 'components/syslog/config';
"/software/components/syslog/config" = {
    prepend(
        dict(
            "action", # no double quotes for text literal!
            "if ($programname == 'slapd' and not ($msg contains 'ACCEPT') and not ($msg contains 'unrecognized')) then ~"
            ));
    prepend(dict("selector", list(dict("facility", "local4",
                                         "priority", "warning")),
                  "action", "-/var/log/slapd.log"));
};

include 'components/altlogrotate/config';

prefix "/software/components/altlogrotate/entries/slapd";

'compress' = true;
'create' = true;
'frequency' = 'daily';
'global' = true;
'include' = '/etc/logrotate.d';
'rotate' = 3;
'pattern' = "/var/log/slapd.log";
'missingok' = true;
'nomail' = true;
