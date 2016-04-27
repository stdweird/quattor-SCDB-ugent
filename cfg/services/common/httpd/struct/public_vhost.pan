@{ Defines an SSL server that is public to the UGent network, and
    maybe the Internet.  }

structure template common/httpd/struct/public_vhost;

include 'common/httpd/struct/default_vhost';
"ssl/certificatefile"=  "/etc/pki/tls/certs/cert.pem";
"ssl/certificatekeyfile" =  "/etc/pki/tls/private/key.pem";
"ssl/cacertificatefile" = "/etc/pki/CA/certs/cabundle-hpcugent.pem";
