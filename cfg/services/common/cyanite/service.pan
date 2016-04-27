unique template common/cyanite/service;

include 'common/cassandra/service';

# YAML metaconfig gives incorrect output..
include 'common/cyanite/config';

variable CYANITE_JAVA_MEM ?= 2048;

prefix '/software/packages';
"cyanite" = dict(); 

prefix "/software/components/sysconfig/files/cyanite";

"JAVA_HOME" = "/usr/lib/jvm/jre-1.8.0";
"JAVA_OPTS" = format("'-Xmx%sM -Xms%sM'", CYANITE_JAVA_MEM, CYANITE_JAVA_MEM);
"epilogue" = "export JAVA_HOME JAVA_OPTS";

"/software/components/chkconfig/service/cyanite" = dict("on", "", "startstop", true);
