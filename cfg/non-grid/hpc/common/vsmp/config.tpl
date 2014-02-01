unique template common/vsmp/config;


include {'common/vsmp/sysctl'};

## service-trim disables all services and reenables the whitelisted ones
#variable VSMP_SERVICE_TRIM_WHITELIST = list(
#    'anacron','atd','autofs','crond','gpm',
#    'haldaemon','messagebus','netfs','network',
#    'nfslock','portmap','portreserve','postfix',
#    'readahead_early','rhnsd','rhsmcertd','rpcbind',
#    'rsyslog','sshd','syslog','sysstat','udev-post',
#    'uuidd','xfs','xinetd','ypbind'
#);



