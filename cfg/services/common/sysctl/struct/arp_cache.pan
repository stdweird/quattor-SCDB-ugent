structure template common/sysctl/struct/arp_cache;

# Prevent ARP table overflow
'net.ipv4.neigh.default.gc_thresh1' = format('%s', 2*1024);
'net.ipv4.neigh.default.gc_thresh2' = format('%s', 3*1024);
'net.ipv4.neigh.default.gc_thresh3' = format('%s', 4*1024);
'net.ipv4.neigh.default.base_reachable_time' = format('%s', 4*3600);
'net.ipv4.neigh.default.gc_stale_time' = format('%s', 4*3600);
'net.ipv4.neigh.default.gc_interval' = format('%s', 4*3600);
