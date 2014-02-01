unique template common/vsmp/scalemp/service;

## this template will modify the slaves according to the mapping

variable SCALEMP_PROFILE_PREFIX ?= '';


include { 'common/vsmp/scalemp/schema' };


## this will conflict with cloning
variable SCALEMP_MASTER_MAP ?= nlist(
    "master1", list("slave11","slave12"),
    "master2", list("slave21","slave22"),
);

variable BOARD_DEV_TYPE ?= "ib";
variable BOARD_DEV_ID ?= "ib0";


function get_board_id = {
    ## return the board id
    ## grep the \d+ from the BOARD_ID_DEV location field
    if (ARGC == 0) {
        hn=OBJECT;
    } else if (ARGC == 1) {
        hn = ARGV[0];
    } else {
        error("get_board_id: Max one argument "+to_string(ARGV));
    };


    path=format("/hardware/cards/%s/%s/location",BOARD_DEV_TYPE,BOARD_DEV_ID);
    if (! match(hn,"^"+OBJECT+"$")) {
        ## prefix remote path
        path=format("%s%s:%s",SCALEMP_PROFILE_PREFIX,hn,path);
    };

    if (path_exists(path)) {
        val=value(path);
        id=matches(val,'(\d+)\s*$');
        if (length(id) == 0) {
            error(format("get_board_id: no id match for value %s of path %s",val,path));
        } else  {
            return(to_long(id[1]));
        };
    } else {
        error(format("get_board_id: No path %s found for location of device %s",path,BOARD_DEV_ID));
    };
};


function to_fqdn = {
    ## 2 args: hostname, domainname.
    ## if domainname is not matching suffix, append it and return
    hn=ARGV[0]; ## hostname
    dn=ARGV[1]; ## domainname

    if (match(hn,'\.'+dn+'$') ) {
        fqdn=hn;
    } else {
        fqdn = hn+'.'+dn;
    };

    return(fqdn);
};


variable VSMP_SCALEMP_CONFIG = {
    ## this node short hostname
    tns = replace('\..*$','',OBJECT);
    ## the domain name of this node
    tnd = replace('^.*?\.','',OBJECT);

    ## match on short names
    thisnode = tns;

    ## part of which master?
    master=undef;
    slaves=undef;
    isslave=true;
    foreach (m;slvs;SCALEMP_MASTER_MAP) {
        if(match(thisnode,'^'+m)) {
            master=m;
            isslave=false;
            slaves=slvs;
        } else {
            foreach(idx;sl;slvs) {
                if(match(thisnode,'^'+sl)) {
                    master=m;
                    slaves=slvs;
                };
            };
        };
    };
    if (!is_defined(master)) {
        ## return error for now?
        error("No master found for host "+thisnode+ " SCALEMP_MASTER_MAP "+to_string(SCALEMP_MASTER_MAP) );
        return(null);
    };

    ## convert to fqdn
    fqdnmaster=to_fqdn(master,tnd);

    fqdnslaves=list();
    foreach(idx;slv;slaves) {
        append(fqdnslaves,to_fqdn(slv,tnd));
    };

    ## slaves do not requires all board ids
    ## start with own id
    boards=list(get_board_id());
    if (! isslave) {
        foreach (idx;slv;fqdnslaves) {
            append(boards,get_board_id(slv));
        };
    };


    t=nlist(
        "master",fqdnmaster,
        "slaves",fqdnslaves,
        "boards",boards,
        "isslave", isslave,
    );

    t;
};

'/software/components/vsmp' = nlist(
    "master",VSMP_SCALEMP_CONFIG["master"],
    "slaves",VSMP_SCALEMP_CONFIG["slaves"],
    "boards",VSMP_SCALEMP_CONFIG["boards"],
);
## disable it, since no real component
'/software/components/vsmp/active' = false;
'/software/components/vsmp/dispatch' = false;


variable VSMP_SCALEMP_NETBOOT ?= true;
include { if(VSMP_SCALEMP_NETBOOT) { 'common/vsmp/scalemp/netboot' }; };

variable VSMP_SCALEMP_CUSTOMKERNEL ?= true;
include { if(VSMP_SCALEMP_CUSTOMKERNEL) {'common/vsmp/scalemp/kernel'} };

include {
    if (VSMP_SCALEMP_CONFIG["isslave"]) {
        'common/vsmp/scalemp/secondary'
    } else {
        'common/vsmp/scalemp/primary'
    };
};

## create monitoring hostgroup
"/system/monitoring/hostgroups" = {
    append(SELF,"scalemp_"+VSMP_SCALEMP_CONFIG["master"]);
    SELF;
};
