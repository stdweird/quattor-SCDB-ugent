unique template common/zookeeper/packages;

variable OS_REPOSITORY_LIST = append("cloudera-cdh4");

prefix "/software/packages";
"{zookeeper-server}" = nlist();
"{java-1.6.0-openjdk}" = nlist(); # not a dependency
