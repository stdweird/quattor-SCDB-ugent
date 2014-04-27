declaration template site/functions;

#
# This function copies the network parameters in the global
# variable NETWORK_PARAMS (an nlist) to SELF.  Self must be
# an nlist and is usually at the path
# /system/network/interfaces.
############################################################
function copy_network_params = {

  if (is_defined(SELF) && is_nlist(SELF)) {
    tbl = SELF;
  } else {
    tbl = nlist();
  };

  # Assume one-to-one correspondence between NIC cards and device eth<n>.
  # Also assume that the same network parameters will be used for each
  # device.  Change this function if these assumptions are not true.
  base = "/hardware/cards/nic";
  nics = value(base);

  device = "";
  foreach(i;v;nics) {
    if (value("/hardware/cards/nic/"+to_string(i)+"/boot")) {
        if (exists("/hardware/cards/nic/"+to_string(i)+"/driver")) {
            tbl[to_string(i)] = merge(NETWORK_PARAMS,nlist("driver",value("/hardware/cards/nic/"+to_string(i)+"/driver")));
        } else {
            tbl[to_string(i)] = NETWORK_PARAMS;
        };
    };
  };

  tbl;
};




# Returns the number of cores on a hardware structure, given as argument.
function cores_in_hardware = {

    hw = ARGV[0];
    cores = 1;

    if (exists (hw["cpu"][0]["cores"]) && is_defined (hw["cpu"][0]["cores"])) {
	cores = hw["cpu"][0]["cores"];
    };

    return (length(hw["cpu"])*cores);
};

# Returns the number of cores on a given hardware template.
function cores_in_hw_template = {
     tpl = ARGV[0];
     hw = create (tpl);
     return (cores_in_hardware (hw));
};


## add file contents to filecopy
function copy_file = {
    ##
    ## Arg1 : destination filename
    ## Arg2 : namespaced file to read content from
    ## Arg3 : optional, nlist with other attributes or some shortcuts
    ##

    if (length (ARGV) == 2) {
        extra = nlist();
    } else if (length (ARGV) == 3) {
        ## shortcuts for a few very common attributes
        if (is_long(ARGV[2])) {
            if (ARGV[2] == 0) {
                extra = nlist('owner','root:root',
                              'perms','0755'
                            );
            } else if (ARGV[2] == 1) {
                extra = nlist('owner','root:root',
                              'perms','0644'
                            );
            } else {
                error("copy_file: shortcut "+to_string(ARGV[2])+" undefined")
            };
        } else if (is_nlist(ARGV[2])) {
            extra = ARGV[2];
        } else {
            error("copy_file: 3rd arguments is either a long (shortcuts) or a nlist.")
        };
    } else {
       error ("function copy_file expects minum 2 arguments, 3rd one optional");
    };

    fn=ARGV[1];
    #if (! is_defined(if_exists(fn))) {
    #    error("copy_file: source "+fn+" not found.");
    #};

    ## real work
    npush(escape(ARGV[0]),
          merge(nlist('config',file_contents(fn)),
                extra)
         );
};


function snr = {
    name = "snr";
    if (ARGC != 3) {
        error(name+": requires 2 arguments: search,replace,string");
    };

    s = to_string(ARGV[0]);
    r = to_string(ARGV[1]);
    res = to_string(ARGV[2]);

    ind = index(s,res);

    while (ind != -1 ) {
        res = splice(res,ind,length(s),r);
        ind = index(s,res);
    };

    return(to_string(res));
};

function booltoyesno = {
    name = "boottoyesno";
    if (ARGC != 1) {
        error(name+": requires 1 argument: a boolean");
    };

    if (! is_boolean(ARGV[0])) {
        error(name+": argument must be a boolean (or use "+name+"(to_boolean()) construct)");
    };
    if (ARGV[0]) {
        return("yes");
    } else {
        return("no");
    };
};


function total_ram = {
    ## return total amount of ram in machine
    t=0;

    foreach (k;v;value("/hardware/ram")) {
        t=t+v["size"];
    };
    return(t);
};


# Function to extract the domain part of a full hostname
function domain_from_fqdn = {
    m = matches(ARGV[0],"([^\\.]+)(\\.(.*))?");

    size = length(m);
    if (size >= 2) {
    	if (size >= 4) {
            if (is_fqdn(m[3])) {
                return(m[3]);
            } else {
                error(format("domain_from_fqdn: invalid name: %s for %s",
			     m[3], ARGV[0]));
            };
        } else {
            return(ARGV[0]);
        };
    } else {
        error(format("domain_from_fqdn: can't match domain name from name: %s",
		     ARGV[0]));
    };
};

# Returns the correct URL for the repository with implied name from structure template.
# Takes as arguments the relative path to the snapshot and 
# an optional minimum snapshot to be used.  Returns the URL
# of the repository. 
# If the wanted snapshot for the repository (as
# declared in OS_SNAPSHOT_REPOSITORY) is older than the global
# snapshot, an error will be risen.
# An empty string ('') is always considered more recent then a fixed version; 
# also if it is used as minimal snapshot (i.e. using an empty string as minimal 
# snapshot version sets the "free float" behaviour).
variable YUM_REPOSITORY_SERVER_HTTP ?= "geodude.ugent.be";
variable YUM_REPOSITORY_SERVER_HTTPS ?= YUM_REPOSITORY_SERVER_HTTP;
 
function url_for_repo = {
    relpath = ARGV[0];

    name = value("name");
        
    # default snapshot
    min_snapshot = OS_SNAPSHOT;
    if (ARGC > 1) {
        min_snapshot = ARGV[1];
    };

    
    if (exists(OS_SNAPSHOT_REPOSITORY[name])) {
        snapshot = OS_SNAPSHOT_REPOSITORY[name]; 
    } else {
        # take most recent the minimal snapshot or OS_SNAPSHOT
        if(length(min_snapshot) == 0 || length(OS_SNAPSHOT) == 0) {
            snapshot = '';
        } else {
            if(OS_SNAPSHOT > min_snapshot) {
                snapshot = OS_SNAPSHOT;
            } else {
                snapshot = min_snapshot;
            };
        };
    };

    # sanity check
    # if snapshot is '', it is considered more recent then anything, so no check is needed
    if(length(snapshot) > 0) {
        if(length(min_snapshot) == 0) {
            error(format("%s: Snapshot for repository %s: %s, but minimal requirement is '' (i.e. free float)",
                 OBJECT, name, snapshot));
        } else {
            if(snapshot < min_snapshot) {
                error(format("%s: Too old snapshot for repository %s: %s, should be at least: %s",
                     OBJECT, name, snapshot, min_snapshot));
            };
        };
    };


    v = value("protocols/0");
    if (exists(v["cacert"])) {
        debug(format("%s: Processing an SSL repository: %s", OBJECT, name));
        if (exists("/software/components/spma/proxy") &&
            value("/software/components/spma/proxy") == "yes") {
            url = format("https://%s:%d/%s/%s", QUATTOR_SERVER, 8443, snapshot,
                         relpath);
        } else {
            url = format("https://%s/%s/%s", YUM_REPOSITORY_SERVER_HTTPS, snapshot, relpath);
        };
    } else {
        debug(format("%s: Processing a non-SSL repository: %s", OBJECT, name));
        url = format("http://%s/%s/%s", YUM_REPOSITORY_SERVER_HTTP, snapshot, relpath);
    }
};
