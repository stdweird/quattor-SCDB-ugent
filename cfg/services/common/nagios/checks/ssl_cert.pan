unique template common/nagios/checks/ssl_cert;

variable CHECK_NAME = "check_ssl_cert";

'/software/components/nrpe/options/command' =
    npush(CHECK_NAME,
          format("%s/%s -H %s  -p $ARG1$ -w $ARG2$ -c $ARG3$ -cacert /etc/pki/CA/certs/cabundle-hpcugent.pem",
           CHECKS_LOCATION, CHECK_NAME, FULL_HOSTNAME));
