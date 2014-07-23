unique template repository/config/rhel7fix;

prefix "/software/packages";
#RHEL7
"{ipython}" = null;
"{pbzip2}" = null;
"{iperf}" = null;
"{iperf3}" = nlist();

include { 'repository/config' };
# allow epel nagios-plugins
# remove exclude pkgs for now
"/software/repositories" = {
    foreach(idx;repo;SELF) {
        if(repo["name"] == "epel") {
	    SELF[idx]["excludepkgs"] = null; 
	};
    };
    SELF;
};
