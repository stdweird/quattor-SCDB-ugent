unique template common/perfsonar/bwctl/service;

include {'common/perfsonar/bwctl/config'};

include {'components/chkconfig/config'};

"/software/components/chkconfig/service/bwctld" = nlist("on", "", "startstop", true);

include {'components/accounts/config'};

"/software/components/accounts/users/bwctl" = nlist(
    "comment", "BWCTL account",
    "uid", 490, "groups", list("bwctl"),
    "homeDir", "/var/lib/bwctl",
    "createHome", true,
    "shell", "/sbin/nologin");

"/software/components/accounts/groups/bwctl/gid" = 490;
