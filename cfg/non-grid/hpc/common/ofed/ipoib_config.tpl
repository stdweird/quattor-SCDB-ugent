unique template common/ofed/ipoib_config;

# add configured network device files using ncm-network
# this should be sufficient

include { 'common/ofed/ipoib_network' };

# these devices will form 1 bonded device
variable IPOIB_BONDING_DEVS ?= list();
variable IPOIB_BOND_IDX ?= 0;
"/system/network/interfaces/" = {
    ipoib_devs = nlist();
    foreach (k;v;IPOIB_DEVS) {
        if (path_exists('/hardware/cards/ib/'+k)) {
            ipoib_devs[k]=v;
        };
    };
    if (length(ipoib_devs) == 0) {
        error(format("No ipoib devs %s matched with hardware (at least one has to be defined, also with bonding)", to_string(IPOIB_DEVS)));
    };

    foreach(idx;dev;IPOIB_BONDING_DEVS) {
        if(!exists(ipoib_devs[dev])) {
            if (path_exists('/hardware/cards/ib/'+k)) {
                ipoib_devs[dev]='bondonly_dummyvalue';
            };
        };
    };

    bonddef=undef;
    foreach(idx;dev;IPOIB_BONDING_DEVS) {
        if(!exists(ipoib_devs[dev])) {
            error(format("slave device %s from IPOIB_BONDING_DEVS %s must be in ipoib_devs %s", dev, to_string(IPOIB_BONDING_DEVS), to_string(ipoib_devs)));
        };
        
        bonddev=format('bond%d', IPOIB_BOND_IDX);
        if (idx == 0) {
            ipoib_devs[bonddev]=ipoib_devs[dev];
        };
        delete(ipoib_devs[dev]);
        
        # set up the slaves
        SELF[dev]=nlist("bootproto", "none",
                        "master", bonddev);
    };

    foreach (k;v;ipoib_devs) {
        SELF[k] = IPOIB_NETWORK_PARAMS;
        SELF[k]['ip'] = ipoib_ip_map(value("/system/network/interfaces/"+v[0]+"/ip"),v[1]);
    };
    
    if(is_defined(bonddev)) {
        SELF[bonddev]["driver"]="bonding";
        SELF[bonddev]["mtu"] = if(IPOIB_CM) {
            # connected mode
            if(path_exists('/software/components/ofed/openib/options/ipoib_mtu')) {
                value('/software/components/ofed/openib/options/ipoib_mtu');
            } else {
                # schema default
                32*1024;
            };
        } else {
            # datagram mode
            2044;
        };

        # new style, without bonding alias etc etc in modprobe
        SELF[bonddev]["bonding_opts"]=nlist(
            "mode", 1, # "active-backup"
            "miimon",100, 
            "primary", IPOIB_BONDING_DEVS[0],
            "updelay", 0,
            "downdelay", 0,
        );
    };
    SELF;
};

# add bondX modprobe setting (is required for boot; not for ifup)
# no harm if not used?
prefix "/software/components/filecopy/services/{/etc/modprobe.d/ipoib_bonding.conf}";
"owner" = "root";
"group" = "root";
"backup" = false;
"config" =  if (length(IPOIB_BONDING_DEVS) > 0) {
        format("alias bond%d bonding\noptions bond%d mode=1\n",IPOIB_BOND_IDX,IPOIB_BOND_IDX);
    } else {
        "# No IPOIB bonding configured";
    };
    