unique template common/logstash/packages;

prefix "/software/packages";

"{logstash}" = nlist();
"{logstash-patterns}" = nlist();

# dependency, not in package
'{java-1.6.0-openjdk}' = nlist();
