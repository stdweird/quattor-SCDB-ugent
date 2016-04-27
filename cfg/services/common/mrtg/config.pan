unique template common/mrtg/config;

include 'metaconfig/mrtg/config';

prefix "/software/components/metaconfig/services/{/etc/mrtg/mrtg.cfg}/contents";
"HtmlDir" = "/var/www/mrtg";
"ImageDir" = "/var/www/mrtg";
"LogFormat" = "rrdtool";
"LogDir" = "/var/lib/mrtg";
"ThreshDir" = "/var/lib/mrtg";
"WorkDir" = "/var/lib/mrtg";
"LibAdd" = "/opt/rrdtool-1.4.4/lib/perl";

"/software/packages/{mrtg}" = dict();
