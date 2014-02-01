@maintainer{
    name = Luis Fernando Muñoz Mejías
    email = Luis.Munoz@UGent.be
}

@{
   Template describing a basic HTTPS virtual host.
}

structure template common/httpd/struct/default_vhost;

"servername" = FULL_HOSTNAME;
"port" = 443;
"documentroot" = "/var/www/https";
"ip/0" = DB_IP[HOSTNAME];
"ssl" = create("common/httpd/struct/basic_ssl");
