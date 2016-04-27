structure template common/sysctl/struct/common;

# Max open files
'fs.file-max' = format('%s', 256*1024);

'net.ipv4.conf.all.arp_filter' = '1';

# Allow more connections to be handled
# decrease timeout connection
'net.ipv4.tcp_fin_timeout' = '30';
# decrease time default for alive time
'net.ipv4.tcp_keepalive_time' = '1800';
'net.ipv4.tcp_syncookies' = '0';
'net.ipv4.ip_local_port_range' = format('%s %s', 32768, 61000);

'net.core.rmem_default' = format('%s', 256*1024);
'net.core.rmem_max' = format('%s', 16*256*1024);
'net.core.wmem_default' = format('%s', 256*1024);
'net.core.wmem_max' = format('%s', 16*256*1024);

'net.netfilter.nf_conntrack_generic_timeout' = '120';
'net.netfilter.nf_conntrack_tcp_timeout_established' = '86400';

#"fs.aio-max-size" = format('%s',1*1024*1024);
