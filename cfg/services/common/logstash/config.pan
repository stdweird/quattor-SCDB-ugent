@{
    Configuration template for logstash
}

unique template common/logstash/config;

final variable METACONFIG_LOGSTASH_VERSION = '2.0';

include 'components/metaconfig/config';
include 'components/dirperm/config';
include 'components/sysconfig/config';

variable LOGSTASH_JAVA_MEM_MAX ?= 64;
variable LOGSTASH_TMP_DIR ?= "/var/tmp/logstash";

include 'metaconfig/logstash/config';

# The exact contents of the file must be provided by the service definitions.
prefix "/software/components/metaconfig/services/{/etc/logstash/conf.d/logstash.conf}";
"contents" ?= dict("output", dict(
    "plugins", list(dict(
        "gelf", dict(
            "custom_fields", dict("type", "remotegelf"),
            "host", SYSLOG_RELAY,
            "sender", HOSTNAME,
            ),
        )),
));

"/system/monitoring/hostgroups" = append("logstash");

prefix "/software/components/dirperm";

"paths" = {
    foreach (i; path; list("/var/log/logstash", "/var/run/logstash", LOGSTASH_TMP_DIR, "/var/lib/logstash")) {
        append(dict("owner", "logstash:logstash", "type", "d", "perm", "0750",
                     "path", path));
    };
};

"dependencies/pre" = append("accounts");
"/software/components/metaconfig/dependencies/pre" = append("dirperm");

prefix "/software/components/sysconfig/files/logstash";
"epilogue" = "export JAVA_HOME";
"JAVA_HOME" = "/usr/lib/jvm/jre-1.8.0"; # openjdk 1.8.0 support
"LS_JAVA_OPTS" = format("'-Djava.io.tmpdir=%s'", LOGSTASH_TMP_DIR);
"LS_HEAP_SIZE" = format("%sm", LOGSTASH_JAVA_MEM_MAX);  # this the same as LOGSTASH_JAVA_MEM_X?
# point to files, otehrwise all files in dir incl .rpmsave and friends
"LS_CONF_DIR" = "/etc/logstash/conf.d/logstash.conf";
# logstash will look for logstash/{filters,...}/*rb in each pluginpath
"LS_OPTS" = "'--pluginpath /usr/share'";

# give logstash user access to the ccm key for beats plugin
"LS_GROUP" = "ccmcert";
