@maintainer{
    name = Luis Fernando Muñoz Mejías
    email = Luis.Munoz@UGent.be
}

@{
    Template defining mod_passenger (the Apache module for Ruby
    applications) as a service that can be imported or included by
    other applications.
}

unique template common/passenger/service;

include 'common/httpd/service';

include 'common/passenger/config';
