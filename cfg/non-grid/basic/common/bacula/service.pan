unique template common/bacula/service;


include { 'common/bacula/config' };
include 'common/bacula/packages';

# add extra user for remote ssh from director to get ILM data
"/software/components/accounts/groups/baculadirector/gid" = 800;
prefix "/software/components/accounts/users/baculadirector";
"homeDir" = "/home/baculadirector";
"shell" = "/bin/bash";
"uid" = 800;
"groups" = list("baculadirector");
"createHome" = true;

# give sudo rights
include {'components/sudo/config'};
"/software/components/sudo/privilege_lines" = append(
        nlist("user", "baculadirector", "host", "ALL", "run_as", "ALL",
              "options", "NOPASSWD:", "cmd", "/test123"));
