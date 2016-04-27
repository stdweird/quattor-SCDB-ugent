unique template common/django/config;

variable DJANGO_SERVER ?= undef;
variable DJANGO_IS_SERVER ?= { FULL_HOSTNAME == DJANGO_SERVER };

include { if(DJANGO_IS_SERVER) { 'common/django/server' } };

include 'common/django/rpms/packages';

prefix "/software/components/metaconfig/services/{/etc/httpd/conf.d/wsgi.conf}/contents/vhosts";

# rewrite http to https
"rewrite_http" = create('common/httpd/struct/https_rewrite');

"django" = create("common/httpd/struct/default_vhost");
"django/directories" = {
    l = dict();
    l["name"] =  "/var/www/django/static";
    l["ssl"] = dict("requiressl", true);
    append(l);
};


prefix "/software/components/metaconfig/services/{/etc/httpd/conf.d/wsgi.conf}/contents/vhosts/django";

"aliases/0/url" = "/django/static/";
"aliases/0/destination" =  "/var/www/django/static/";
"aliases/1/url" = "/django";
"aliases/1/destination" = "/var/www/django/wsgi.py";
"aliases/1/type" = "wsgiscript";
"wsgi/passauthorization" = "on";

# can only be set in systemwide setting
prefix "/software/components/metaconfig/services/{/etc/httpd/conf.d/wsgi.conf}/contents/global";
"wsgipythonpath" = "/var/www/django";


include 'components/metaconfig/config';
prefix '/software/components/metaconfig/services/{/etc/accountpage_db.conf}/contents';

"MAIN" = dict(
    "django_db_user", DJANGO_DB_USER,
    "django_db_password", DJANGO_DB_PASSWORD,
    );

prefix '/software/components/metaconfig/services/{/etc/accountpage_db.conf}';
'module' = 'python/configparser';
'group' = 'apache';
'mode' = 0640;

'/software/packages/{python-psycopg2}' = dict();


include 'components/dirperm/config';
# create log dir
"/software/components/dirperm/paths" = append(dict(
    "path", '/var/log/django',
    "owner", "apache:apache",
    "perm", "0750",
    "type", "d",
));
