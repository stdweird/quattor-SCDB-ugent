@maintainer{
    name = Luis Fernando Muñoz Mejías
    email = Luis.Munoz@UGent.be
}

@{
    Template defining mod_wsgi (the Apache module for Python
    applications) as a service that can be imported or included by
    other applications.

    This is meant to be included by the specific applications.
}

unique template common/trac/service;

include {'common/wsgi/service'};

include {'common/trac/config'};
