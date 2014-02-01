unique template common/sysctl/old_config;

include {"common/sysctl/default_rhel6"};


include {if (USE_BLCR) { 'common/sysctl/blcr' } };

prefix "/software/components/sysctl/variables";
# other limits
'kernel.msgmni' = '1024';
# Controls the maximum size of a message, in bytes
'kernel.msgmnb' = format('%s',64*1024);
# Controls the default maxmimum size of a mesage queue
'kernel.msgmax' = format('%s',64*1024);

# Max open files
'fs.file-max' = format('%s', 64*1024);

# Allow more connections to be handled
# decrease timeout connection
'net.ipv4.tcp_fin_timeout' = '30';
# decrease time default for alive time
'net.ipv4.tcp_keepalive_time' = '1800';

'net.ipv4.tcp_syncookies' = '0';
'net.ipv4.ip_local_port_range' = format('%s %s',32768, 61000);
'net.core.rmem_default' = format('%s', 256*1024);
'net.core.rmem_max' = format('%s',256*1024);

# shared memory
# settings needed for eg gamess-us
# shmmax 2GB (per core)
# shmall = all = 16GB in pages
'kernel.shmmax' = format('%s', 2*1024*1024*1024);
'kernel.shmmni' = format('%s', 16*1024);
'kernel.shmall' = format('%s', total_ram() *1024*1024 / (4*1024)); # in pages (page sie = getconf PAGE_SIZE)

'kernel.sem' = format('%s %s %s %s', 250, 32000, 100, 1024);

'net.ipv4.conf.all.arp_filter' = '1';

# others
#"fs.aio-max-size" = format('%s',1*1024*1024);
