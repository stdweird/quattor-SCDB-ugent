unique template common/moab/server/rpms/packages;

include 'dict/versions';

# We versionlock MOAB RPMs for now.

'/software/packages'=pkg_repl('moab-server',MOAB_VERSION,'x86_64');
## contrib (eg the sql init files)
'/software/packages'=pkg_repl('moab-contrib',MOAB_VERSION,'x86_64');
## el6 fix
'/software/packages'=pkg_repl('moab-odbc-fix',MOAB_VERSION,'x86_64');
