unique template common/shorewall/config;

include {'components/shorewall/config'};

variable SHOREWALL_ZONES_DEFAULT ?= nlist("type","ipv4");
variable SHOREWALL_ZONES ?= list(
    nlist('zone','fw',
          'type','firewall'),
    nlist('zone','ext'),
);
'/software/components/shorewall/zones' = {
    foreach(ind;int;SHOREWALL_ZONES) {
        foreach(k;v;SHOREWALL_ZONES_DEFAULT) {
            if (! is_defined(int[k])) {
                int[k]=v;
            };
        };
        append(SELF,int);
    };
    SELF;
};

variable SHOREWALL_INTERFACES_DEFAULT ?= nlist(
    "broadcast",list("detect"),
    "options",list("arp_filter"),
);
variable SHOREWALL_INTERFACES ?= list(
    nlist("interface","eth0",
          "zone","ext"),  
); 
'/software/components/shorewall/interfaces' = {
    foreach(ind;int;SHOREWALL_INTERFACES) {
        foreach(k;v;SHOREWALL_INTERFACES_DEFAULT) {
            if (! is_defined(int[k])) {
                int[k]=v;
            };
        };
        append(SELF,int);
    };
    SELF;
};


variable SHOREWALL_POLICY_DEFAULT ?= nlist(); 
variable SHOREWALL_POLICY ?= list(
    nlist("src","fw",
          "dst","all",
          "policy","accept",
          ),
    ## this one always last
    nlist("src","all",
          "dst","all",
          "policy","reject",
          "loglevel","info"
          ),
);
'/software/components/shorewall/policy' = {
    foreach(ind;int;SHOREWALL_POLICY) {
        foreach(k;v;SHOREWALL_POLICY_DEFAULT) {
            if (! is_defined(int[k])) {
                int[k]=v;
            };
        };
        append(SELF,int);
    };
    SELF;
};

## no defaults for RULES?
variable SHOREWALL_RULES ?= list(
    nlist("action","accept",
          "src",nlist("zone","fw",),
         ),  
#    nlist("action","reject",
#          "src",nlist("zone","fw",'address',list('1.2.3.4','~AA:BB:CC:DD:EE:FF')),
#          "dst",nlist("zone","fw",'interface',"eth0"),
#          'user','root','group','testgroup',
#            )
); 
'/software/components/shorewall/rules' = SHOREWALL_RULES;

variable SHOREWALL_SHOREWALL ?= nlist(
    'startup_enabled',true,
    'ip_forwarding','Off'
);
'/software/components/shorewall/shorewall' = SHOREWALL_SHOREWALL;