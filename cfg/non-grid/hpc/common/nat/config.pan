unique template common/nat/config;

variable NAT_HAS_EXT ?= true;
variable SHOREWALL_POLICY = {
    t=list();
    src_dst_accept = list(
        list("fw","all"),
        list("int","fw"),
    );
    if (NAT_HAS_EXT) {
        append(src_dst_accept,list("int","ext"));
    };
    foreach(idx;src_dst;src_dst_accept) {
        append(t,nlist(
                    "src",src_dst[0],
                    "dst",src_dst[1],
                    "policy","accept",
                    ));
    };
    ## this one always last
    append(t,nlist(
                "src","all",
                "dst","all",
                "policy","reject",
                "loglevel","info"
                ));
    t;
};


# define bunch of variables before the include
include 'common/shorewall/service';

prefix "/software/components/shorewall";

include 'site/shorewall/interfaces';
include 'site/shorewall/zones';
include 'site/shorewall/rules';

"shorewall/ip_forwarding" = {if (NAT_HAS_EXT) {"On"} else {"Off"}};
"shorewall/startup_enabled" = true;

include 'common/nat/masq';
include 'common/nat/hosts';
include 'components/sysctl/config';

"/software/components/sysctl/variables/net.ipv4.conf.all.arp_filter" = "1";
