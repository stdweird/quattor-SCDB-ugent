unique template common/pbsmon2php/config;

variable PBSMON2PHP_SECRETS_LOC ?= "/etc/pbsmon2php/pwdfile";
include 'components/filecopy/config';
variable CONTENTS_PBSMON2PHP_SECRETS ?= undef;

final variable PBSMON2PHP_SECRETS_FMT = <<EOF;
%s
EOF

variable CONTENTS_PBSMON2PHP_SECRETS = format(PBSMON2PHP_SECRETS_FMT, RSYNC_PBSMON2PHP_PWD);


'/software/components/filecopy/services' =
  npush(escape(PBSMON2PHP_SECRETS_LOC),
        dict('config',CONTENTS_PBSMON2PHP_SECRETS,
              'owner','root:root',
              'perms', '0600'));

include 'components/cron/config';


"/software/components/cron/entries" = append(
    dict("command", "/usr/bin/getAllFiles.py",
	  "name", "pbsmon-getfiles",
	  "comment", "PBSmon log file retrieval",
	  "user", "root",
	  "group", "root",
	  "timing", dict("minute", "*/3")));

include 'common/pbsmon2php/httpd';
