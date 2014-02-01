unique template common/elasticsearch/nfs;

include {'components/nfs/config'};

variable ELASTICSEARCH_NFS_VOLUME ?= null;

"/software/components/nfs/mounts" = {
    v = value("/software/components/metaconfig/services/" +
	"{/etc/elasticsearch/elasticsearch.yml}/contents/gateway/fs");
    append(nlist("device", ELASTICSEARCH_NFS_VOLUME,
	    "mountpoint", v,
	    "fstype", "nfs",
	    "options", "rw,noatime,soft,intr,tcp,rsize=32768,wsize=32768"));
};

"/software/components/chkconfig/dependencies/pre" = append("nfs");
