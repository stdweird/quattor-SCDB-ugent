structure template common/postgresql/sysconfig/metaconfig;

# only use this if you are not using ncm-postgres

"module" = "tiny";
"mode" = 0644;
"daemons" = dict("postgresql", "restart");
