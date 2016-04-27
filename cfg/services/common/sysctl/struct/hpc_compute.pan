structure template common/sysctl/struct/hpc_compute;

#let users use 'perf'
'kernel.perf_event_paranoid' = '0';

# VM
'vm.dirty_ratio' = '80';
'vm.dirty_background_ratio' = '50';
'vm.zone_reclaim_mode' = '3';

# can't have these anymore for java reasons
#'vm.overcommit_memory' = '2';
#'vm.overcommit_ratio' = '100';


# gigE ethernet settings
'net.ipv4.tcp_mem' = format('%s %s %s', 96*1024, 128*1024, 192*1024);
'net.core.rmem_default' = format('%s', 64*1024); # in pages
'net.core.wmem_default' = format('%s', 64*1024); # in pages
'net.core.wmem_max'= format('%s', 8*1024*1024);

# Enable low latency mode for TCP:
'net.ipv4.tcp_low_latency' = '1';
'net.ipv4.tcp_window_scaling' = '1';
