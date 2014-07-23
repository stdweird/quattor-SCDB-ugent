@maintainer{
    name = Luis Fernando Muñoz Mejías
    email = Luis.Munoz@UGent.be
}

@{
    Template setting up the basics for a Django application
}

unique template common/django/config;

include {'common/django/packages'};

prefix "/software/components/metaconfig/services/{/etc/httpd/conf.d/wsgi.conf}/contents/vhosts";

"django" = create("common/httpd/struct/default_vhost");
"django/directories" = {
    l = nlist();
    l["name"] =  "/var/www/django/static";
    l["ssl"] = nlist("requiressl", true);
    append(l);
};

prefix "/software/components/metaconfig/services/{/etc/httpd/conf.d/wsgi.conf}/contents/vhosts/django";
"ssl/certificatefile" = format("/etc/pki/tls/certs/%s.pem", FULL_HOSTNAME);
"ssl/certificatekeyfile" = format("/etc/pki/tls/private/%s.key", FULL_HOSTNAME);
"ssl/cacertificatefile" = null;
"ssl/certificatechainfile" = "/etc/pki/CA/private/TERENASSLCA-Chain.crt";

"aliases/0/url" = "/django/static/";
"aliases/0/destination" =  "/var/www/django/static/";
"aliases/1/url" = "/django";
"aliases/1/destination" = "/var/www/django/accountpage/wsgi.py";
"aliases/1/type" = "wsgiscript";
"wsgi/passauthorization" = "on";

# can only be set in systemwide setting
prefix "/software/components/metaconfig/services/{/etc/httpd/conf.d/wsgi.conf}/contents/global";
"wsgipythonpath" = "/var/www/django";
