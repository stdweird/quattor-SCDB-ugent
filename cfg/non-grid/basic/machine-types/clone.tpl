##
## This template makes clones from other profiles
##

unique template machine-types/clone;

##
## template to set variables
##
variable CLONE_SITE_TEMPLATE ?= "site/clone";
include { if_exists(CLONE_SITE_TEMPLATE)};

## nlists with nodename as key
## node<->ip map
variable CLONE_SITE_IP_MAP ?= undef;
## node <-> hardware map
variable CLONE_SITE_MACHINE_MAP ?= undef;
## variable to load the typical DB_IP and DB_MACHINE variables
## DB_IP and DB_MACHINE will be used when CLONE_SITE_IP_MAP and CLONE_SITE_MACHINE_MAP are undef
## done like this to avoid double loading of final database variables
## this template is only included when cloning, so not for the master
variable CLONE_DATABASE_VARIABLES ?= "site/databases";

## prefix for the profiles.
variable CLONE_PROFILE_PREFIX ?= '';

##
## hostnames are masters
## be aware of not using fqdn. the domain name of the current node will be used when the match is found
## if the current node is a clone of the masters, will be tried in this order
##
variable CLONE_MASTERS ?= list();
## nlist of master and machine-types
## is optional; when empty, assumes the master is created some other way
variable CLONE_MASTER_MACHINETYPE ?= nlist();
## clones
## either specify a full list (FQDN hostname will be checked)
## nlist of master and list of clones
variable CLONE_CLONES ?= nlist();
## the regexp will use the regexp to check the hostname
## nlist with master as key, regexp as value
variable CLONE_CLONES_REGEXP ?= nlist();
## exclude the following nodes from the list or matching regexp
## this is applied first
## nlist with master as key and the regexp
variable CLONE_NO_CLONES_REGEXP ?= nlist();


## list of paths; the values corrsponding to these paths will search-and-replaced masterhostname and nodename
variable CLONE_REPLACE_NODENAME_REGEXP_LIST ?= list(
    '/software/components/ccm/profile',
    '/system/aii/nbp/pxelinux/kslocation',
    '/system/aii/osinstall/ks/node_profile',
    '/system/network/hostname'
);
variable CLONE_REPLACE_ERROR_ON_MISSING_PATH ?= true;
## use full hostname search and replace?
## make sure DOMAINNAME is defined
variable CLONE_REPLACE_NODENAME_REGEXP_FULLNAME ?= false;

## hardware
## replace master hardware with hardware from CLONE_SITE_MACHINE_MAP
variable CLONE_REPLACE_HARDWARE ?= true;
## list of hardware parts to replace.
## warning: types are NOT rechecked. be aware of mandatory default values set through type definitions (eg part_prefix) !!
variable CLONE_REPLACE_HARDWARE_PARTS ?= list(
    "location",
    "serialnumber",
    "site",
    "vendor",
    "model",
    "type",
    "support",
    "rack/name",
    "cards/nic",
    #"cards/ib"
);

## the network section (not the hostname!)
##
## this one is more tricky because of routes and vlans etc etc
## in principle all supported IPs should be changed
## what is supported? ncm-network network style
##
## real code will use an nlist with as key the node name and per adapter the correct ip
## we need a good function for network related remapping of IPs based on netmasks that can generate this list
##
variable CLONE_REPLACE_IP_CONFIG ?= true;

##
## hardware section
##
## replace the whole hardware section with what can be found from CLONE_SITE_MACHINE_MAP
##

##
## magic section
##

variable CLONEINFO = {
    ## get fqdn of this node
    if ( length(CLONE_PROFILE_PREFIX) > 0 ) {
      thisnode = replace(CLONE_PROFILE_PREFIX,'',OBJECT);
    } else {
      thisnode = OBJECT;
    };
    ## this node short hostname
    tns = replace('\..*$','',thisnode);
    ## the domain name of this node
    tnd = replace('^.*?\.','',thisnode);

    master = undef;
    i = 0;
    while ((i< length(CLONE_MASTERS)) && (! is_defined(master))) {
        m = CLONE_MASTERS[i];

        clone = true;
        ## this node is the master
        if ((m == thisnode) || (m == tns)) {
            master = m;
            clone = false;
        };

        mm = undef;
        ## first check: no_clone match
        ## first with fqdn, then with shortname
        if (is_defined(CLONE_NO_CLONES_REGEXP[m])) {
            mm = m;
        } else if (is_defined(CLONE_NO_CLONES_REGEXP[m+'.'+tnd])) {
            mm = m+'.'+tnd;
        };
        ## stop? next in while loop
        if (is_defined(mm) && match(thisnode,CLONE_NO_CLONES_REGEXP[mm])) {
            clone = false;
        };

        if (clone) {
            mm = undef;
            ## regular search through list CLONE_CLONES
            if (is_defined(CLONE_CLONES[m])) {
                mm = m;
            } else if (is_defined(CLONE_CLONES[m+'.'+tnd])) {
                mm = m+'.'+tnd;
            };

            if (is_defined(mm)) {
                ## we only expect one hit
                foreach (i;node;CLONE_CLONES[mm]) {
                    if ((node == thisnode) || (node == tns)) {
                        master = mm;
                    };
                };
            };
            if (! is_defined(master)) {
                mm = undef;
                ## check for regexp in CLONE_CLONES_REGEXP
                if (is_defined(CLONE_CLONES_REGEXP[m])) {
                    mm = m;
                } else if (is_defined(CLONE_CLONES_REGEXP[m+'.'+tnd])) {
                    mm = m+'.'+tnd;
                };
                if (is_defined(mm) && match(thisnode,CLONE_CLONES_REGEXP[mm])) {
                    master = mm;
                };
            };
        };
        ## next element
        i=i+1;
    };
    if (! is_defined(master)) {
        ## no master found?
        ## this means that this node is not a clone of anything
        ## then why the clone template?
        error("clone :no matching master found for node "+thisnode);
    };

    cloning = true;
    ## is master == thisnode?
    if ((master == thisnode) || (master == tns)) {
        cloning = false;
    };

    masterfqdn = master;
    if (! match(master,'\..*$')) {
        masterfqdn = master+"."+tnd;
    };


    nlist(
        "master",master,
        "cloning",cloning,
        "masterfqdn",masterfqdn,
        "thisnode",thisnode,
        "tns",tns);
};


## following variable should be reset in eg SCDB
variable PKG_REPOSITORY_CONFIG ?= null;

##
## When the current node is the master, either do nothing or start from another machine-type
## through CLONE_MASTER_MACHINETYPE nlist
##
include {
    mm = CLONEINFO["master"];
    if ((! CLONEINFO["cloning"]) && is_defined(mm) && is_defined(CLONE_MASTER_MACHINETYPE[mm])) {
        return(CLONE_MASTER_MACHINETYPE[mm]);
    };
    return(undef);
};


## manual loading of possible final variables
include {
    if (CLONEINFO["cloning"] && is_defined(CLONE_DATABASE_VARIABLES)) {
        ## load the DATABASE variables
        return(CLONE_DATABASE_VARIABLES);
    };
    return(undef);
};

## extra for hardware templates
variable CLONE_PAN_UNITS ?= "pan/units";
include {
    if (CLONEINFO["cloning"] && CLONE_REPLACE_HARDWARE && is_defined(CLONE_PAN_UNITS)) {
        ## load the DATABASE variables
        return(CLONE_PAN_UNITS);
    };
    return(undef);
};


## actual cloning here
## least amount of root tree copying as possible
"/" = {

    if (CLONEINFO["cloning"]) {
        ## clone the master
        ## need fqdn of master
	path = format("%s%s:/", CLONE_PROFILE_PREFIX, CLONEINFO["masterfqdn"]);
        if (! path_exists(path)) {
            error("clone master path not found:"+path)
        };
	value(path);
    } else if (is_defined(SELF)) {
	SELF;
    } else {
	error ("WTF!");
    };
};

## 2 step process to have the actual values (for path_exists to work)
"/" = {
    mm = CLONEINFO["master"];
    ## now we know that this node has master to make clone from

    if (CLONEINFO["cloning"]) {
        tns = CLONEINFO["tns"];
        thisnode = CLONEINFO["thisnode"];
        ## replace all values

        ## regexps
        foreach(i;path;CLONE_REPLACE_NODENAME_REGEXP_LIST) {
            if (path_exists(path)) {
                txt = value(path);
                ps = split("/",path);
                clref = SELF;
                foreach (j;p;ps) {
                    ## first one is empty?  last one can't be used
                    ## (ref of nlist can't be changed to eg string,
                    ## which these all are)
                    if (j > 0 && j < (length(ps)-1)) {
                        clref = clref[p];
                    };
                };
                #error("mm "+mm+" tns "+tns+" txt "+txt);
                clref[ps[length(ps)-1]] = replace(mm,tns,txt);
            } else if (CLONE_REPLACE_ERROR_ON_MISSING_PATH) {
		error("clone replace: path doesn't exist:"+path);
	    };
        };

        ## hardware
        if (CLONE_REPLACE_HARDWARE) {
            if (is_defined(CLONE_SITE_MACHINE_MAP) && length(CLONE_SITE_MACHINE_MAP) > 0) {
                csmm = CLONE_SITE_MACHINE_MAP;
            } else if (is_defined(DB_MACHINE) && length(DB_MACHINE) > 0) {
                csmm = DB_MACHINE;
            } else {
                error("clone: no valid machine map found in either CLONE_SITE_MACHINE_MAP or DB_MACHINE");
            };


            if (is_defined(csmm[thisnode])) {
                hwt = csmm[thisnode];
            } else if (is_defined(csmm[tns])) {
                hwt = csmm[tns];
            } else {
                hwt = undef;
            };

            if (is_defined(hwt)) {
                newhw = create(hwt);
                foreach (i;part;CLONE_REPLACE_HARDWARE_PARTS) {
                    clref = SELF['hardware'];
                    newhwref = newhw;

                    ps = split("/",part);
                    foreach (j;p;ps) {
                        if ( (! (p == '')) && (j < (length(ps)-1))) {
                            if (! is_defined(clref[p])) {
                                error("clone: part ("+part+":sub "+p+") not found in master ("+mm+") hardware");
                            };
                            clref = clref[p];
                            if (! is_defined(newhwref[p])) {
                                error("clone: part ("+part+":sub "+p+") not found in clone ("+thisnode+") hardware");
                            };
                            newhwref = newhwref[p];
                        };
                    };
                    clref[ps[length(ps)-1]] = clone(newhwref[ps[length(ps)-1]]);
                };
            } else {
                error("clone: hardware template for current node not found/defined: "+thisnode+" ("+tns+")");
            };
        };

        ## network
        if (CLONE_REPLACE_IP_CONFIG) {
            ## check /system/network/interfaces for ips
            if (is_defined(SELF['system']['network']['interfaces'])) {
                if (is_defined(CLONE_SITE_IP_MAP)) {
                    if (is_nlist(CLONE_SITE_IP_MAP)) {
                        ipl = CLONE_SITE_IP_MAP;
                    } else if (CLONE_SITE_IP_MAP == 'make_ip_map_from_db_ip') {
                        ## assume this exists
                        ipl = make_ip_map_from_db_ip(DB_IP);
                    };
                } else {
                    ## autogenerate the list
                    ## default from DB_IP, assume eth0
                    if (is_defined(DB_IP[thisnode])) {
                        nn = thisnode;
                    } else if (is_defined(DB_IP[tns])) {
                        nn = tns;
                    } else {
                        error("clone: Can't generate ip info for this node "+thisnode+" ("+tns+")")
                    };
                    dev = "eth0";
                    l = nlist(dev,DB_IP[nn]);
                    ipl = nlist(tns,l);
                };


                if (is_defined(ipl[thisnode])) {
                    newip = ipl[thisnode];
                } else if (is_defined(ipl[tns])) {
                    newip = ipl[tns];
                } else {
                    error("clone: no ips found for node "+thisnode+" ("+tns+") in CLONE_SITE_IP_MAP "+to_string(ipl));
                };
                foreach(int;opts;SELF['system']['network']['interfaces']) {
                    if (is_defined(opts['ip'])) {
                        if (is_defined(newip[int])) {
                            opts['ip'] = newip[int];
                        } else {
                            error("clone: no IP defined in CLONE_SITE_IP_MAP for node "+thisnode+" ("+tns+") interface "+int);
                        };
                    };
                };
            } else debug("Don't have network interfaces for " + OBJECT);
        };
    };


    SELF;
};

## the resulting template is NOT type checked!!
## can give problems with default values defined in the types
## eg when replacing a part of the tree with a create(declaration_templation)
## (real example: replacing the machine hardware like this, will not set the part_prefix = '')
