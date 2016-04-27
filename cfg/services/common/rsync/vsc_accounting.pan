structure template common/rsync/vsc_accounting;

"comment" = "pbs accounting logs for vsc";
"lock_file" = "/var/lock/rsyncd";
"auth_users/0" = "pbsacc";
"secrets_file" = RSYNC_SECRETS_LOC;
"path" = "/var/spool/pbs/server_priv/accounting";
"hosts_allow" = RSYNCD_VSC_HOSTS_ALLOW;
"max_connections" = 1;
