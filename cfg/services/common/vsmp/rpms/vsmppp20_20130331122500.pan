unique template common/vsmp/rpms/vsmppp20_20130331122500;

prefix "/software/packages";
"{xfsprogs}" = dict();

## vsmp contains getinfo.sh and vsmptools.sh+install.sh
'/software/packages'=pkg_repl('vsmp','2.1.0-1.ug','x86_64');

## others
'/software/packages'=pkg_repl('libvsmpclib','0.1-5','x86_64');
'/software/packages'=pkg_repl('numabind','1.2.8-2012134','x86_64');
