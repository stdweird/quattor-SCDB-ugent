unique template common/sysctl/default_rhel6;

prefix "/software/components/sysctl/variables";

"net.ipv4.ip_forward" = "0";
# Controls source route verification
"net.ipv4.conf.default.rp_filter" = "1";

# Do not accept source routing
"net.ipv4.conf.default.accept_source_route" = "0";

# Controls the System Request debugging functionality of the kernel
"kernel.sysrq" = "0";

# Controls whether core dumps will append the PID to the core filename.
# Useful for debugging multi-threaded applications.
"kernel.core_uses_pid" = "1";

# Controls the use of TCP syncookies
"net.ipv4.tcp_syncookies" = "1";

# Disable netfilter on bridges.
"net.bridge.bridge-nf-call-ip6tables" = "0";
"net.bridge.bridge-nf-call-iptables" = "0";
"net.bridge.bridge-nf-call-arptables" = "0";
