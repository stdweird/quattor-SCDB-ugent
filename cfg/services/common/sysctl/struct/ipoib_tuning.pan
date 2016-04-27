structure template common/sysctl/struct/ipoib_tuning;

# infiniband IP settings (can affect ethernet settings);
# do you really need it? (it will disrupt gigE tuning, and most IB uses verbs, not IP)

'net.ipv4.tcp_timestamps' = '0';
'net.ipv4.tcp_sack' = '0';
'net.ipv4.tcp_rmem' = format('%s %s %s', 1*1024*1024, 10*1024*1024, 16*1024*1024);
'net.ipv4.tcp_wmem' = format('%s %s %s', 1*1024*1024, 10*1024*1024, 16*1024*1024);
'net.ipv4.tcp_mem' = format('%s %s %s', 1*1024*1024, 10*1024*1024, 16*1024*1024);

'net.core.rmem_max' = format('%s', 16*512*1024);
'net.core.wmem_max' = format('%s', 16*512*1024);
'net.core.rmem_default' = format('%s', 512*1024);
'net.core.wmem_default' = format('%s', 512*1024);
'net.core.optmem_max' = format('%s', 16*512*1024);

'net.core.netdev_max_backlog' = format('%s', 200*1000);
