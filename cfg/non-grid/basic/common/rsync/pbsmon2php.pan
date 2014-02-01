structure template common/rsync/pbsmon2php;

"comment" = "json pbs mon file";
"lock_file" = "/var/lock/rsyncd_pbsmon2php";
"auth_users/0" = "pbsmon2php";
"secrets" = RSYNC_SECRETS_LOC;
"path" = "/var/run/pbsmon2php";
"hosts_allow" = RSYNCD_HOSTS_ALLOW;
