unique template common/goldproxy/config;

include {'components/filecopy/config'};
include {'components/chkconfig/config'};

"/software/components/filecopy/services/{/etc/goldProxy.cfg}" =
    nlist('config', format(file_contents("site/files/goldProxy.cfg"),
			   GOLD_AUTH_KEY_MOAB,
			   GOLD_AUTH_KEY_MOAB),
	  'owner', 'root:root',
	  'perms', '0600',
	  'restart', '/usr/sbin/goldProxy restart');

"/software/components/chkconfig/service/goldProxy/on" = "";
"/software/components/chkconfig/service/goldProxy/startstop" = true;

