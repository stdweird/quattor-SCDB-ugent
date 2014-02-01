unique template common/mongodb/config;

prefix "/software/components/metaconfig/services/{/etc/mongodb.conf}";

"module" = "tiny";
"contents/logpath"="/var/log/mongo/mongod.log";
"contents/logappend"=true;
"contents/fork" = true;
"contents/dbpath"="/var/lib/mongo";
