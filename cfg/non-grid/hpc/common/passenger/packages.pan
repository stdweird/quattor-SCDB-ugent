unique template common/passenger/packages;


# to be set in common/passenger/config
variable PASSENGER_VERSION ?= undef;

"/software/packages" = {
    pkg_repl("mod_passenger*",PASSENGER_VERSION, PKG_ARCH_DEFAULT);
    pkg_repl("rubygems-passenger*",PASSENGER_VERSION, PKG_ARCH_DEFAULT);
    SELF;
};

# all deps on el6
#"{rubygem-fastthread}" = nlist();
#"{rubygem-passenger}" = nlist();
#"{rubygem-passenger-native}" = nlist();
#"{rubygem-passenger-native-libs}" = nlist();
#"{rubygem-rack}" = nlist();
#"{rubygem-rake}" = nlist();
#"{rubygems}" = nlist();
#"{ruby-irb}" = nlist();
#"{ruby-rdoc}" = nlist();
#"{libev}" = nlist();
