unique template common/ctdb/logging;

variable CTDB_LOGFILE ?= "/var/log/log.ctdb";
variable CTDB_LOG_SYSLOG ?= true;

"/software/components/sysconfig/files/ctdb" = {
    if (CTDB_LOG_SYSLOG) {
        SELF["CTDB_SYSLOG"] = "yes";
    } else {
        SELF["CTDB_LOGFILE"] = CTDB_LOGFILE;
    };
    SELF;
};


include {'components/altlogrotate/config'};
"/software/components/altlogrotate/entries/ctdb" = {
    if (CTDB_LOG_SYSLOG) {
        null;
    } else {
        nlist(
            "compress", true,
            "create", true,
            "frequency", "weekly",
            "createparams", nlist(
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