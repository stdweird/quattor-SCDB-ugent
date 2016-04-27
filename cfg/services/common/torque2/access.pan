unique template common/torque2/access;

## restrict access to nodes with jobs only (also exclude masters)
## using the settings in /etc/pam.d/sshd and /etc/secutiry/access.conf

## set following variable to '#' to allow all
variable TORQUE_ACCESS_SECURITY_ACCESS ?= "";
variable TORQUE_ACCESS_ALLOWED_USERS ?= list("root", "nagios");
variable TORQUE_ACCESS_ALLOWED_GROUPS ?= list("wheel");

variable CONTENTS = {

    l = "";
    g = "";

    foreach (i; user; TORQUE_ACCESS_ALLOWED_USERS) {
		l = format("%s %s", l, user);
    };

    foreach (i; group; TORQUE_ACCESS_ALLOWED_GROUPS) {
	   	g = format("%s (%s)", g, group);
    };

    header = '# Restrict access to adm and selected users only';
    format("%s\n%s-:ALL EXCEPT %s %s:ALL\n", header,
	   TORQUE_ACCESS_SECURITY_ACCESS, l, g);
};

'/software/components/filecopy/services' =
  npush(escape("/etc/security/access.conf"),
        dict('config',CONTENTS,
              'owner','root:root',
              'perms', '0644',
              ));


## sshd settings
## define following variable to "" to ignore
variable TORQUE_ACCESS_PAM_SSHD ?= <<EOF;
account    sufficient   pam_pbssimpleauth.so debug
account    required     pam_access.so nodefgroup
EOF


variable CONTENTS = <<EOF;
#%PAM-1.0
EOF


variable CONTENTS = CONTENTS +TORQUE_ACCESS_PAM_SSHD+ <<EOF;
auth       include      system-auth
account    required     pam_nologin.so
account    include      system-auth
password   include      system-auth
session    optional     pam_keyinit.so force revoke
session    include      system-auth
session    required     pam_loginuid.so
EOF

'/software/components/filecopy/services' =
  npush(escape("/etc/pam.d/sshd"),
        dict('config',CONTENTS,
              'owner','root:root',
              'perms', '0644',
              ));

## this should be fixed in the rpms though...
## fixed in 2.4.3 ug.1 rpms
#include {'components/symlink/config'};
#"/software/components/symlink/links" = {
#  links = SELF;
#  if ( !is_defined(links) || !is_list(links) ) {
#    links = list();
#  };
#
#  links[length(links)] = dict(
#        "name", "/lib64/security/pam_pbssimpleauth.so",
#        "target", "/lib64/pam_pbssimpleauth.so",
#        "exists", false,
#        "replace", dict("all","yes")
#  );
#  links;
#};


#include {'common/pam/service'};
#"/software/components/pam/services/sshd" = dict(
#        "password", list(
#                        dict("control","include",
#                              "module","system-auth"),
#                    ),
#        "auth", list(
#                    dict("control","include",
#                          "module","system-auth"),
#                ),
#        "session",list(
#                dict("control","optional",
#                      "module","pam_keyinit.so",
#                      "options",dict(
#                        "force",true,
#                        "revoke",true)),
#                dict("control","include",
#                      "module","system-auth"),
#                dict("control","required",
#                      "module","pam_loginuid.so"),
#                ),
#        "account",list(
#                dict("control","required",
#                      "module","pam_nologin.so"),
#                dict("control","include",
#                      "module","system-auth"),
#                ),
#);
