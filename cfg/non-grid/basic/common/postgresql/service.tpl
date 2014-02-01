unique template common/postgresql/service;


include { 'common/postgresql/packages' };

include { 'common/postgresql/config' };

"/system/monitoring/hostgroups" = {
    append(SELF,"postgres_servers");
    SELF;
};

include { 'components/accounts/config' };

"/software/components/accounts/groups/postgres" =
  nlist("gid", 26);

"/software/components/accounts/users/postgres" = nlist(
  "uid", 26,
  "groups", list("postgres"),
  "comment","postgres",
  "shell", "/bin/sh",
  "homeDir", "/var/lib/pgsql"
);


include {if_exists('site/backup/postgres')};
