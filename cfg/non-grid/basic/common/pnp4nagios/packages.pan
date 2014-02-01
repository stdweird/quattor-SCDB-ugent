unique template common/pnp4nagios/packages;

prefix "/software/packages";

"/software/packages" = pkg_repl("pnp4nagios", "0.6.16-1.el6", "x86_64");

"{rrdtool-perl}" = nlist();
"{rrdtool}" = nlist();
"{perl-Time-HiRes}" = nlist();

# This is a home-grown package, and we should probably take it out of
# the "standard" directory. General public are allowed to do stupid
# things and not to use RRD caches with PNP4Nagios, anyways.
"{rrdcached}" = nlist();
"{pnp4nagios-templates-ugent}" = nlist();
