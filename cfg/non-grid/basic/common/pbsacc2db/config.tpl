unique template common/pbsacc2db/config;

variable PBSACC2DB_SECRETS_LOC ?= "/var/pbsacc2db/rsyncd.secrets";

include { 'components/filecopy/config' };

variable CONTENTS_PBSACC2DB_SECRETS ?= undef;

final variable PBSACC2DB_SECRETS_FMT = <<EOF;
%s
EOF

variable CONTENTS_PBSACC2DB_SECRETS = format(PBSACC2DB_SECRETS_FMT, RSYNC_PBSACC_PWD);

'/software/components/filecopy/services' =
  npush(escape(PBSACC2DB_SECRETS_LOC),
        nlist('config',CONTENTS_PBSACC2DB_SECRETS,
              'owner','root:root',
              'perms', '0600'));

prefix "/software/components/metaconfig/services/{/etc/httpd/conf.d/ssl.conf}/contents";

"aliases" = append(nlist("destination", "/var/www/pbsacc2db",
                         "url", "/pbsacc2db"));
"vhosts/base/directories" = append(
    nlist("auth",
          nlist("name", "pbsacc2db access",
                "type", "Basic",
                "userfile", "/etc/icinga/htpasswd.users"),
          "name", "/var/www/pbsacc2db",
          ));
