unique template common/pacemaker/crm;

variable PRESOURCEPREFIX = "_master_";

variable PMASTERIP ?= "192.168.10.254";
variable PNIC ?= "eth0";
variable PNETMASK ?= "24";
variable PIFACELABEL ?= "0";

variable PINTERVAL ?= 60;
variable PTIMEOUT ?= 10;
variable PMON ?= "op monitor interval="+to_string(PINTERVAL)+" timeout="+to_string(PTIMEOUT);

## order is important when reused in PGROUP!!
variable PSERVICES ?= list("pbs_server","maui","dhcpd");

variable PGROUP ?= merge(list("ip"),PSERVICES);
variable PGROUPMETA ?= "meta target_role=started";
"/software/components/pacemaker/crm/resources" = {
    el = 'primitive';
    if (!(is_defined(SELF[el]) && is_list(SELF[el]))) {
        SELF[el] = list();
    };
    if (is_defined(PMASTERIP)) {
        SELF[el][length(SELF[el])] = "resource"+PRESOURCEPREFIX+"ip ocf:heartbeat:IPaddr params ip="+PMASTERIP+" nic="+PNIC+" cidr_netmask="+PNETMASK+" iflabel="+PIFACELABEL+" "+PMON;
    };
    if (is_defined(PSERVICES)) {
        foreach(i;serv;PSERVICES) {
            SELF[el][length(SELF[el])] = "resource"+PRESOURCEPREFIX+serv+" lsb:"+serv+" "+PMON;
        };
    };

    el = 'group';
    if (!(is_defined(SELF[el]) && is_list(SELF[el]))) {
        SELF[el] = list();
    };
    if (is_defined(PGROUP)) {
        PGROUPTXT = "";
        foreach(i;serv;PGROUP) {
             PGROUPTXT= PGROUPTXT+"resource"+PRESOURCEPREFIX+serv+" ";
        };
        SELF[el][length(SELF[el])] = "group"+PRESOURCEPREFIX+"services " +PGROUPTXT+PGROUPMETA;
    };
    
    SELF;
};

variable PMASTERINF ?= true;
"/software/components/pacemaker/crm/constraints" = {
    el = 'location';
    if (!(is_defined(SELF[el]) && is_list(SELF[el]))) {
        SELF[el] = list();
    };
    
    if (PMASTERINF) {
        step = 10;
        begin = step*length(HA_NODES);

        foreach (count;node;HA_NODES) {
            ## first node is inf master
            if (count == 0) {
                level = 'inf';
            } else {
                level = to_string(begin-step*count);
            };
            SELF[el][length(SELF[el])] =  "location_"+to_string(count)+" group"+PRESOURCEPREFIX+"services "+level+": "+node;
        };
    };
    SELF;    
};

#
# disbale stonith
#
"/software/components/pacemaker/crm/attributes/property"=list(
    "stonith-enabled=false"
);


