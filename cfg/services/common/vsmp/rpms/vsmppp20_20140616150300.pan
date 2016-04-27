unique template common/vsmp/rpms/vsmppp20_20140616150300;

prefix "/software/packages";
"{xfsprogs}" = dict();

## vsmp contains getinfo.sh and vsmptools.sh+install.sh
'/software/packages'=pkg_repl('vsf_tools','5.5.155.27-2.ug','x86_64');

## others
'/software/packages'=pkg_repl('libvsmpclib','0.1-5','x86_64');
'/software/packages'=pkg_repl('numabind','1.2.8-2012134','x86_64');
