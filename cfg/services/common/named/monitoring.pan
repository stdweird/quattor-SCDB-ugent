unique template common/named/monitoring;

prefix "/software/components/nrpe/options/command";

"check_dns" = "/usr/lib64/nagios/plugins/check_dns -s 127.0.0.1 -H localhost";
