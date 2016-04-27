unique template common/pnp4nagios/packages;


variable PNP4NAGIOS_VERSION ?= if(RPM_BASE_FLAVOUR_VERSIONID < 7) {"0.6.16"} else {"0.6.25-1"};

"/software/packages" = pkg_repl("pnp4nagios", format("%s*", PNP4NAGIOS_VERSION), "x86_64");

prefix "/software/packages";
"{rrdtool-perl}" = dict();
"{rrdtool}" = dict();
"{perl-Time-HiRes}" = dict();

# This is a home-grown package, and we should probably take it out of
# the "standard" directory. General public are allowed to do stupid
# things and not to use RRD caches with PNP4Nagios, anyways.
"{rrdcached}" = dict();
"{pnp4nagios-templates-ugent}" = dict();
