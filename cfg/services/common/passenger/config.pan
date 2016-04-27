@maintainer{
    name = Luis Fernando Muñoz Mejías
    email = Luis.Munoz@UGent.be
}

@{
    Template setting up the basics for a Ruby Application
}

unique template common/passenger/config;

include 'components/metaconfig/config';
include 'metaconfig/httpd/schema';

variable PASSENGER_VERSION ?= '3.0.21';

include 'common/passenger/packages';

variable PASSENGER_POOL_SIZE ?= 10;

bind "/software/components/metaconfig/services/{/etc/httpd/conf.d/rails.conf}/contents" = httpd_vhosts;

prefix "/software/components/metaconfig/services/{/etc/httpd/conf.d/rails.conf}";
"mode" = 0644;
"owner" = "root";
"group" = "root";
"daemons" = dict("httpd", "restart");
"module" = "httpd/passenger";

prefix "/software/components/metaconfig/services/{/etc/httpd/conf.d/rails.conf}/contents";
"vhosts/passenger" = create("common/httpd/struct/public_vhost",
    "documentroot", "/does/not/exist",
    "port", 443);

"passenger/maxpoolsize" ?= PASSENGER_POOL_SIZE;
# these are also set in passenger.conf from the mod_passenger rpm
"passenger/root" = format("/usr/share/rubygems/gems/passenger-%s", PASSENGER_VERSION);
"modules/passenger_module" = format("modules/mod_passenger.so");
