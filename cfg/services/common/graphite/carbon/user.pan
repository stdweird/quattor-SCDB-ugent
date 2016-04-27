unique template common/graphite/carbon/user;

# basedir for storage etc etc
variable CARBON_BASEDIR ?= "/var/lib/carbon";

variable CARBON_USERID ?= 495;

# carbon user
"/software/components/accounts/groups/carbon" =
  dict("gid", CARBON_USERID);

"/software/components/accounts/users/carbon" = dict(
  "uid", CARBON_USERID,
  "groups", list("carbon"),
  "comment","Carbon daemon user",
  "shell", "/sbin/nologin",
  "homeDir", CARBON_BASEDIR,
);
include 'components/dirperm/config';
"/software/components/dirperm/paths" = append(dict(
    "path",    CARBON_BASEDIR,
    "owner",   "carbon:carbon",
    "perm",    "0755",
    "type",    "d",
    ));
