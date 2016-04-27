structure template common/rsync/pbsacc;

"comment" = "pbs accounting logs";
"lock_file" = "/var/lock/rsyncd";
"auth_users/0" = "pbsacc";
"secrets_file" = RSYNC_SECRETS_LOC;
"path" = "/var/spool/pbs/server_priv/accounting";
"hosts_allow" = RSYNCD_HOSTS_ALLOW;
