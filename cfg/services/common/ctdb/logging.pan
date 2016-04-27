unique template common/ctdb/logging;

variable CTDB_LOGFILE ?= "/var/log/log.ctdb";
variable CTDB_LOG_SYSLOG ?= true;

"/software/components/metaconfig/services/{/etc/sysconfig/ctdb}/contents/service" = {
    if (CTDB_LOG_SYSLOG) {
        SELF["ctdb_syslog"] = true;
    } else {
        SELF["ctdb_logfile"] = CTDB_LOGFILE;
    };
    SELF;
};
include 'components/altlogrotate/config';
"/software/components/altlogrotate/entries/ctdb" = {
    if (CTDB_LOG_SYSLOG) {
        null;
    } else {
        dict(
            "compress", true,
            "create", true,
            "frequency", "weekly",
            "createparams", dict(
                "group", "root",
                "owner", "group",
                "mode", '0644',
            ),
            "pattern", CTDB_LOGFILE,
            "rotate", 10,
            "ifempty", false,
            "missingok", true,
        );
    };
};
