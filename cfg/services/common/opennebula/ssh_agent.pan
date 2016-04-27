unique template common/opennebula/ssh_agent;

prefix "/software/components/systemd/unit/{ssh-agent-ONE}";
# defaults are enabled, service and startstop
# do not set file/only=true; this is a service on its own
"file/replace" = true; # this is the unit file of the service

prefix "/software/components/systemd/unit/{ssh-agent-ONE}/file/config";
"unit" = dict(
    "Description", "OpenSSH private key agent for oneadmin",
    "IgnoreOnIsolate", true,
    "After", list("network.target"),
    );
"service" = dict(
    "Type", "forking",
    "Environment", list(dict('SSH_AUTH_SOCK', '/var/lib/one/ssh-agent.socket')),
    "ExecStart", "/usr/bin/ssh-agent -a $SSH_AUTH_SOCK",
    "ExecStartPost", "/usr/bin/ssh-add",
    "User", "oneadmin",
    "Group", "oneadmin",
    );
"install" = dict(
    "WantedBy", list("multi-user.target"),
    "RequiredBy", list("opennebula.service"),
    );


# also set the SSH_AUTH_SOCK env var for opennebula service
prefix "/software/components/systemd/unit/{opennebula.service}";
"file/only" = true; # this is not a service on its own
"file/replace" = false; # this is the unit file of the service
"file/config/service/Environment" = append(dict('SSH_AUTH_SOCK', '/var/lib/one/ssh-agent.socket'));
