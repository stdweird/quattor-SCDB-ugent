unique template common/passenger/packages;


# to be set in common/passenger/config
variable PASSENGER_VERSION ?= undef;

"/software/packages" = {
    pkg_repl("mod_passenger*",PASSENGER_VERSION, PKG_ARCH_DEFAULT);
    pkg_repl("rubygems-passenger*",PASSENGER_VERSION, PKG_ARCH_DEFAULT);
    SELF;
};

# all deps on el6
#"{rubygem-fastthread}" = dict();
#"{rubygem-passenger}" = dict();
#"{rubygem-passenger-native}" = dict();
#"{rubygem-passenger-native-libs}" = dict();
#"{rubygem-rack}" = dict();
#"{rubygem-rake}" = dict();
#"{rubygems}" = dict();
#"{ruby-irb}" = dict();
#"{ruby-rdoc}" = dict();
#"{libev}" = dict();
