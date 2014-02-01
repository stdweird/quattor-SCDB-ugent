unique template common/ofed/ipoib_network;

variable IPOIB_SITE_NETWORK ?= 'site/ipoib_network';
include {IPOIB_SITE_NETWORK};


# IPOIB_DEVS is nlist with (ibname, ethname to base ip on)
variable IPOIB_NETWORK_BCAST ?= null;
variable IPOIB_NETWORK_NETMASK ?= null;

variable IPOIB_NETWORK_PARAMS = nlist(
    "broadcast",IPOIB_NETWORK_BCAST,
    "netmask",IPOIB_NETWORK_NETMASK,
);

variable IPOIB_MATCHDEV ?= boot_nic();
variable IPOIB_DEVS ?= nlist("ib0",list(IPOIB_MATCHDEV,0));


function ipoib_ip_map = {
    currentip = ARGV[0];
    # optional 2nd arg is offset

    # just split off the last blocks and prefix it with IPOIB_NETWORK_RANGE
    ips = matches(currentip,'^(\d+)\.(\d+)\.(\d+)\.(\d+)$');
    if(length(ips) == 0) {
        error("valid ip needed: "+currentip+" seen as "+to_string(ips));
    };

    netw = matches(IPOIB_NETWORK_BCAST,'^(\d+)\.(\d+)\.(\d+)\.(\d+)$');

    newip = list('','','','');
    foreach(i;j;list(1,2,3,4)) {
        if (netw[j] == '255') {
            newip[i] = ips[j];
        } else {
            newip[i] = netw[j];
        }
    };

    if (length(ARGV) == 2) {
        # 2nd argument is offset for last IP
        newip[3]=to_string(to_long(newip[3])+ARGV[1]);
    };

    return(newip[0]+'.'+newip[1]+'.'+newip[2]+'.'+newip[3]);
};

