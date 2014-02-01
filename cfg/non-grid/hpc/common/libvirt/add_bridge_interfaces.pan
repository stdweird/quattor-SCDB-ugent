unique template common/libvirt/add_bridge_interfaces; 

# replace interfaces with bridges
variable VM_BRIDGE_OFFSET ?= 100; 
variable VM_BRIDGE_INTERFACES ?= {
    t=list(boot_nic(), 'vlan0');
};

"/system/network/interfaces" = {
    # move from orig device to bridge
    param_move_list=list("bootproto","broadcast","ip","netmask","route","aliases");
    
    foreach(idx;intf;VM_BRIDGE_INTERFACES) {
        brname=format("br%s",VM_BRIDGE_OFFSET+idx);

        if (exists(SELF[brname])) {
            error(format("A bridge %s already exists. Increase the offset VM_BRIDGE_OFFSET (now %s)", brname, VM_BRIDGE_OFFSET));
        };

        if (exists(SELF[intf])) {
            SELF[brname] = nlist(
                "type", "Bridge",    
                "stp", true,
                "delay", 0,
                "linkdelay", 5, # wait seconds from actual devices to come alive
            );
    
            foreach(idx;param;param_move_list) {
                if(exists(SELF[intf][param])) {
                    # make copy of value, no refs (eg route/aliases)
                    SELF[brname][param]=value(format("/system/network/interfaces/%s/%s",intf,param));
                    SELF[intf][param] = null;
                };
            };
        
            # set hard    
            SELF[intf]["bootproto"]="none";
            SELF[intf]["bridge"]=brname;
        } else {
            error(format("Creating bridge device %s from interface %s failed; interface missing.", brname, intf));
        };
        
    };
    SELF;
};

