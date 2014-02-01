unique template common/xinetd/services/tftp;

bind "/software/components/metaconfig/services/{/etc/xinetd.d/tftp}/contents" = xinetd_conf;

"/software/components/metaconfig/services/{/etc/xinetd.d/tftp}" = XINETD_DEFAULT_METACONFIG;

prefix "/software/components/metaconfig/services/{/etc/xinetd.d/tftp}/contents";
"servicename" = "tftp";
"options/server" = "/usr/sbin/in.tftpd";
"options/protocol" = "udp";
"options/socket_type" = "dgram";
"options/flags" = list("IPv4");