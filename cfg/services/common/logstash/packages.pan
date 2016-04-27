unique template common/logstash/packages;

'/software/packages' = pkg_repl("logstash", "2.1.1-3.ug", "noarch");

prefix "/software/packages";

"{logstash-patterns}" = dict();

# dependency, not in package
"{java-1.8.0-openjdk-headless}" = dict();
