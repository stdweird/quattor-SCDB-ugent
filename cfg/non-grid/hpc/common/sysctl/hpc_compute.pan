unique template common/sysctl/hpc_compute;

# do you really need it? (it will disrupt gigE tuning, and most IB users verbs, not IP)
variable SYSCTL_IPOIB_TUNING ?= false;

include {'common/sysctl/default_rhel6'};

prefix "/software/components/sysctl/variables";

# other limits
'kernel.msgmni' = '1024';
# Controls the maximum size of a message, in bytes
'kernel.msgmnb' = format('%s',64*1024);
# Controls the default maxmimum size of a mesage queue
'kernel.msgmax' = format('%s',64*1024);

# Max open files
'fs.file-max' = format('%s', 64*1024);

#let users use 'perf'
'kernel.perf_event_paranoid' = '0';

# VM
'vm.dirty_ratio' = '80';
'vm.dirty_background_ratio' = '50';
'vm.overcommit_memory' = '2';
'vm.overcommit_ratio' = '100';
'vm.zone_reclaim_mode' = '3';

# gigE ethernet settings
'net.ipv4.tcp_mem' = format('%s %s %s', 96*1024, 128*1024, 192*1024);
'net.core.rmem_default' = format('%s', 64*1024); # in pages
'net.core.wmem_default' = format('%s', 64*1024); # in pages
'net.core.wmem_max'= format('%s', 8*1024*1024);

# Enable low latency mode for TCP:
'net.ipv4.tcp_low_latency' = '1';
'net.ipv4.tcp_window_scaling' = '1';

include {if(SYSCTL_IPOIB_TUNING) {'common/sysctl/ipoib_tuning'}};

include {'common/sysctl/arp_cache'};

# Allow more connections to be handled
# decrease timeout connection
'net.ipv4.tcp_fin_timeout' = '30';
# decrease time default for alive time
'net.ipv4.tcp_keepalive_time' = '1800';
'net.ipv4.tcp_syncookies' = '0';
'net.ipv4.ip_local_port_range' = format('%s %s',32768, 61000);
'net.ipv4.conf.all.arp_filter' = '1';

# shared memory
'kernel.shmmax' = format('%s', 200*1024*1024*1024);
'kernel.shmmni' = format('%s', 64*1024);
'kernel.shmall' = format('%s', 10*total_ram() *1024*1024 / (4*1024)); # in pages (page sie = getconf PAGE_SIZE)

# semaphore
'kernel.sem' = format('%s %s %s %s', 250, 32000, 100, 1024);

# others
#"fs.aio-max-size" = format('%s',1*1024*1024);


