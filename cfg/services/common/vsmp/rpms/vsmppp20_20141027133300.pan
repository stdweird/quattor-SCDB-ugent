unique template common/vsmp/rpms/vsmppp20_20141027133300;

prefix "/software/packages";
"{xfsprogs}" = dict();

## vsmp contains getinfo.sh and vsmptools.sh+install.sh
'/software/packages'=pkg_repl('vsf_tools','5.5.429.0-1.ug','x86_64');

# needs to start vsf_lmgr_agent service as of 5.5.295.3
"/software/components/chkconfig/service/vsf_lmgr_agent" = dict("on", "", "startstop", true);


## others
'/software/packages'=pkg_repl('libvsmpclib','0.1-5','x86_64');
'/software/packages'=pkg_repl('numabind','1.2.8-2012134','x86_64');
