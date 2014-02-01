unique template common/moab/server/relocate_home;

variable MOAB_HOME_ALT = "/var/spool/moab";
prefix "/software/components/dirperm";
"paths" = {
    foreach(idx;relpath;list("","log","stats","spool", "checkpoint")) {
        if (relpath == 'spool') {
            perm='1777';
        } else {
            perm='0775';
        };
        append(nlist(
            "path", format("%s/%s", MOAB_HOME_ALT, relpath),
            "owner", "root:moab",
            "perm", perm,
            "type", "d"));
    };
    SELF;
};

prefix "/software/components/moab/main";
"logdir" = format("%s/%s", MOAB_HOME_ALT, "log");
"statdir" = format("%s/%s", MOAB_HOME_ALT, "stats");
"spooldir" = format("%s/%s", MOAB_HOME_ALT, "spool");
"checkpointdir" = format("%s/%s", MOAB_HOME_ALT, "checkpoint");

