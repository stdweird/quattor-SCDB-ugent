@maintainer{
    name = Luis Fernando Muñoz Mejías
    email = Luis.Munoz@UGent.be
}

@{
    Template setting up the basics for a trac application
}

unique template common/trac/config;

include {'common/trac/packages'};

prefix "/software/components/metaconfig/services/{/etc/httpd/conf.d/wsgi.conf}/contents";

"aliases/0/url" = "/django/static/";
"aliases/0/destination" =  "/var/www/django/static/";
"aliases/1/url" = "/django";
"aliases/1/destination" = "/var/www/django/accountpage/wsgi.py";
"aliases/1/type" = "script";
"global/wsgipythonpath" = "/var/www/django";

"vhosts/django" = create("common/httpd/struct/default_vhost");
"vhosts/django/directories" = {
    l = nlist();
    l["name"] =  "/var/www/django/static";
    l["ssl"] = nlist("requiressl", true);
    append(l);
};
