unique template common/cassandra/service;

include 'common/cassandra/config';

variable OS_REPOSITORY_LIST = append('datastax');
prefix '/software/packages';
"dsc21" = dict();
"cassandra21-tools" = dict();

variable CASSANDRA_JAVA_MEM ?= 2048;
# symlink  /usr/share/cassandra/lib/jamm-0.2.6.jar to /usr/share/cassandra/lib/jamm-0.2.8.jar
include 'components/symlink/config';
"/software/components/symlink/links" = push(dict(
    "name", "/usr/share/cassandra/lib/jamm-0.2.6.jar",
    "target", "/usr/share/cassandra/lib/jamm-0.2.8.jar",
    "replace", dict("all","yes"),
    )); 

# /etc/default/cassandra get sourced
prefix "/software/components/sysconfig/files/cassandra";

"JAVA_HOME" = "/usr/lib/jvm/jre-1.8.0";
"JVM_OPTS" = format("'-Xmx%sM -Xms%sM'", CASSANDRA_JAVA_MEM, CASSANDRA_JAVA_MEM);
"epilogue" = "export JAVA_HOME JVM_OPTS";

"/software/components/symlink/links" = push(dict(
    "name", "/etc/default/cassandra",
    "target", "/etc/sysconfig/cassandra",
    "replace", dict("all","yes"),
    )); 

"/software/components/chkconfig/service/cassandra" = dict("on", "", "startstop", true);

# cassandra user
"/software/components/accounts/groups/cassandra" =
  dict("gid", 479);

variable CASSANDRA_BASEDIR ?= "/var/lib/cassandra";

"/software/components/accounts/users/cassandra" = dict(
  "uid", 494,
  "groups", list("cassandra"),
  "comment","Cassandra and Cyanite daemon user",
  "shell", "/bin/bash",
  "homeDir", CASSANDRA_BASEDIR,
);
