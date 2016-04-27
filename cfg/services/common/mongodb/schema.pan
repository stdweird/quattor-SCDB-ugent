declaration template common/mongodb/schema;

type mongodb_config = {
    "logpath" : string = '/var/log/mongo/mongod.log'
    "logappend" : boolean = true
    "fork" : boolean = true
    "port" : type_port = 27017
    "dbpath" : string = "/var/lib/mongo"
    "nojournal" : boolean = true
    "cpu" : boolean = true
    "noauth" : boolean = true
    "auth" : boolean = true
    "verbose" : boolean = true
    "objcheck" : boolean = true
    "quota" : long(0..7) = 0
    "oplog" : long = 0
    "nohints" : boolean = true
    "nohttpinterface" : boolean = true
    "noscripting" : boolean = true
    "notablescan" : boolean = true
    "noprealloc" : boolean = true
    "nssize" ? long
    "mms-token" ? string
    "mms-name" ? string
    "mms-interval" ? long
    "slave" ? boolean
    "source" ? type_fqdn
    "only" ? type_fqdn
    "master" ? boolean
};

bind "/software/components/metaconfig/services/{/etc/mongodb.conf}/contents" = mongodb_config;
