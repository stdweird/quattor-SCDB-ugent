@{ Download the UGent-blessed certificates an HTTPS machine will
    present to its clients.  }

unique template common/httpd/downloadcerts;

include 'common/download/service';

prefix "/software/components/download/files";

"{/etc/pki/tls/certs/cert.pem}" = create("common/download/auth",
                                         "href", format("secure/%s.pem",
                                                        FULL_HOSTNAME),
                                         "perm", "0600");

"{/etc/pki/tls/private/key.pem}" = create("common/download/auth",
                                          "href", format("secure/%s.key",
                                                         FULL_HOSTNAME),
                                          "perm", "0600");

"/system/monitoring/hostgroups" = {
    append("ssl_service_https");
    append("downloadcert");
};
