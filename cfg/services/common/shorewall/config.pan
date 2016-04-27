unique template common/shorewall/config;
include 'components/shorewall/config';
variable SHOREWALL_ZONES_DEFAULT ?= dict("type","ipv4");
variable SHOREWALL_ZONES ?= list(
    dict('zone','fw',
          'type','firewall'),
    dict('zone','ext'),
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

variable SHOREWALL_INTERFACES_DEFAULT ?= dict(
    "broadcast",list("detect"),
    "options",list("arp_filter"),
);
variable SHOREWALL_INTERFACES ?= list(
    dict("interface","eth0",
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


variable SHOREWALL_POLICY_DEFAULT ?= dict(); 
variable SHOREWALL_POLICY ?= list(
    dict("src","fw",
          "dst","all",
          "policy","accept",
          ),
    ## this one always last
    dict("src","all",
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
    dict("action","accept",
          "src",dict("zone","fw",),
         ),  
#    dict("action","reject",
#          "src",dict("zone","fw",'address',list('1.2.3.4','~AA:BB:CC:DD:EE:FF')),
#          "dst",dict("zone","fw",'interface',"eth0"),
#          'user','root','group','testgroup',
#            )
); 
'/software/components/shorewall/rules' = SHOREWALL_RULES;

variable SHOREWALL_SHOREWALL ?= dict(
    'startup_enabled',true,
    'ip_forwarding','Off'
);
'/software/components/shorewall/shorewall' = SHOREWALL_SHOREWALL;
