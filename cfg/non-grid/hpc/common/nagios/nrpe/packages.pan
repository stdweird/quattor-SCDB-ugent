unique template common/nagios/nrpe/packages;

prefix "/software/packages";

"{nagios-plugins}" = nlist();
"{nrpe}" = nlist();
"{icinga-checks-ugent}" = nlist();
