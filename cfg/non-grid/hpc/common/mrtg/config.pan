unique template common/mrtg/config;

include {'components/metaconfig/config'};
include {'common/mrtg/schema'};

prefix "/software/components/metaconfig/services/{/etc/mrtg/mrtg.cfg}";

"module" = "mrtg";
"mode" = 0644;
"owner" = "root";
"group" = "root";

"contents/HtmlDir" = "/var/www/mrtg";
"contents/ImageDir" = "/var/www/mrtg";
"contents/LogFormat" = "rrdtool";
"contents/LogDir" = "/var/lib/mrtg";
"contents/ThreshDir" = "/var/lib/mrtg";
"contents/WorkDir" = "/var/lib/mrtg";
"contents/LibAdd" = "/opt/rrdtool-1.4.4/lib/perl";

"/software/packages/{mrtg}" = nlist();
