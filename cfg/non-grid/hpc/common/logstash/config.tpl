@{
    Configuration template for logstash
}

unique template common/logstash/config;

include {'components/metaconfig/config'};
include {'common/logstash/schema'};
include {'components/dirperm/config'};
include 'components/sysconfig/config';

variable LOGSTASH_JAVA_MEM_X ?= 64;
variable LOGSTASH_JAVA_MEM_S ?= LOGSTASH_JAVA_MEM_X;

prefix "/software/components/metaconfig/services/{/etc/logstash/conf.d/logstash.conf}";

"daemon/0" = "logstash";
"owner" = "root";
"group" = "root";
"mode" = 0644;
"module" = "logstash/main";

# The exact contents of the file must be provided by the service definitions.
"contents" ?= nlist("output", nlist(
    "plugins", list(nlist(
        "gelf", nlist(
            "custom_fields", nlist("type", "remotegelf"),
            "host", SYSLOG_RELAY,
            "sender", HOSTNAME,
            ),
        )),
));

"/system/monitoring/hostgroups" = append("logstash");

prefix "/software/components/dirperm";

"paths" = {
    foreach (i; path; list("/var/log/logstash", "/var/run/logstash", "/var/tmp/logstash")) {
        append(nlist("owner", "logstash:logstash", "type", "d", "perm", "0750",
                     "path", path));
    };
};

"dependencies/pre" = append("accounts");
"/software/components/metaconfig/dependencies/pre" = append("dirperm");

prefix "/software/components/sysconfig/files/logstash";
"epilogue" = "export TMP=/var/tmp/logstash";
"START" = "true";
"HOME" = "/var/lib/logstash";
"LOGSTASH_PATH_CONF" = "/etc/logstash/conf.d/logstash.conf";
"LOGSTASH_JAVA_OPTS" = format("'-Xmx%sM -Xms%sM'", LOGSTASH_JAVA_MEM_X, LOGSTASH_JAVA_MEM_S);
"LOGSTASH_LOGLEVEL" = "warn";
