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

        # OVS eth ports do not require IP
        if (is_defined(VM_OVS_MANAGEMENT_INT)) {
            SELF[intf] = dict();
        };

        if (exists(SELF[intf])) {
            if (LIBVIRT_BRIDGE_INTERFACES == 'ovs') {
                SELF[brname] = dict(
                    "type", "OVSBridge",
                    "ovs_extra", 'set Interface $DEVICE type=internal',
                    "bootproto", "none",
                );
                SELF[intf]["ovs_bridge"]=brname;
                SELF[intf]["type"]="OVSPort";
            } else if (LIBVIRT_BRIDGE_INTERFACES == 'linux') {
                SELF[brname] = dict(
                    "type", "Bridge",
                    "stp", true,
                    "delay", 0,
                    "linkdelay", 5, # wait seconds from actual devices to come alive
                );
                SELF[intf]["bridge"]=brname;
            };
    
            foreach(idx;param;param_move_list) {
                if (exists(SELF[intf][param])) {
                    if (LIBVIRT_BRIDGE_INTERFACES == 'linux') {
                        # make copy of value, no refs (eg route/aliases)
                        SELF[brname][param]=value(format("/system/network/interfaces/%s/%s",intf,param));
                    } else if (LIBVIRT_BRIDGE_INTERFACES == 'ovs' && is_defined(VM_OVS_MANAGEMENT_INT)) {
                        # make copy of value to OVS management net
                        SELF[VM_OVS_MANAGEMENT_INT][param]=value(format("/system/network/interfaces/%s/%s",intf,param));
                    };
                    SELF[intf][param] = null;
                };
            };
        
            # set hard
            SELF[intf]["bootproto"]="none";
        } else {
            error(format("Creating bridge device %s from interface %s failed; interface missing.", brname, intf));
        };
        
    };
    SELF;
};
