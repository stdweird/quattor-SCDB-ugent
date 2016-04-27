structure template common/httpd/struct/https_rewrite;

# rewrite http on port 80
"ip/0" = DB_IP[HOSTNAME];
"port" = 80;
"servername" = FULL_HOSTNAME;
"rewrite/engine" = true;
"rewrite/rules/0/destination" = "https://%{HTTP_HOST}%{REQUEST_URI}";
"rewrite/rules/0/regexp" = "(.*)";
"rewrite/rules/0/conditions/0" = dict(
    "test", '%{HTTPS}',
    "pattern", "off",
);
