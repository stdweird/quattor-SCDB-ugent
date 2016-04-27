unique template common/vsmp/rpms/vsmppp20_20120422080356;

#'/software/packages'=pkg_repl();

## vsmp contains getinfo.sh and vsmptools.sh+install.sh
'/software/packages'=pkg_repl('vsmp','2.0.03-1.ug','x86_64');

## others
'/software/packages'=pkg_repl('libvsmpclib','0.1-5','x86_64');
'/software/packages'=pkg_repl('numabind','1.2.7-2012082','x86_64');
