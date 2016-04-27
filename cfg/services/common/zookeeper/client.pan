unique template common/zookeeper/client;

# only install python kazoo
variable ZOOKEEPER_ONLY_KAZOO ?= true;
"/software/packages" = {
    SELF[escape('python-vsc-zk')] = dict();
    SELF[escape('python-zope-interface')] = dict();
    if (!ZOOKEEPER_ONLY_KAZOO) {
        SELF[escape('zookeeper')] = dict();
    };
    SELF;
};
