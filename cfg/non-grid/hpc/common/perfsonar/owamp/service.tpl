unique template common/perfsonar/owamp/service;

include {'components/dirperm/config'};
include {'components/chkconfig/config'};
include {'components/accounts/config'};

"/software/components/chkconfig/service/owampd" = nlist("on", "",
    "startstop", true);

"/system/monitoring/hostgroups" = append("owamp");

"/software/components/accounts/groups/owamp/gid" = 491;


"/software/components/accounts/users/owamp" = nlist(
    "comment", "OWAMP account",
    "uid", 491, "groups", list("owamp"),
    "homeDir", "/var/lib/owamp",
    "createHome", true,
    "shell", "/sbin/nologin");

"/software/components/dirperm/paths" = append(nlist("path", "/var/lib/owamp",
						    "type", "d",
						    "owner", "owamp:owamp",
						    "perm", "0755"));
