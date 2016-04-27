unique template common/opennebula/ceph_fuse;

"/software/packages/{ceph-fuse}" = dict();

variable CEPH_FUSE_DATASTORE ?= 0;
final variable CEPH_FUSE_DATASTORE_PATH = format("/var/lib/one/datastores/%s", CEPH_FUSE_DATASTORE);

"/software/components/dirperm/paths" = {
     append(dict(
        "path", "/var/lib/one/datastores",
        "owner", "oneadmin:oneadmin",
        "perm", "0775",
        "type", "d",
        ));
     append(dict(
        "path", "/var/lib/one",
        "owner", "oneadmin:oneadmin",
        "perm", "0755",
        "type", "d",
        ));
     append(dict(
        "path", CEPH_FUSE_DATASTORE_PATH,
        "owner", "oneadmin:oneadmin",
        "perm", "0775",
        "type", "d",
        ));
};

prefix "/software/components/systemd/unit/{ceph-fuse-ONE}";
# defaults are enabled, service and startstop
# do not set file/only=true; this is a service on its own
"file/replace" = true; # this is the unit file of the service

prefix "/software/components/systemd/unit/{ceph-fuse-ONE}/file/config";
"unit" = dict(
    "Description", "Ceph fuse libvirt/ONE mount",
    "After", list("network.target"),
    "Requires", list("network.target"),
    "Before", list("libvirtd.service"),
    "Condition", dict(
        "PathIsDirectory", list(CEPH_FUSE_DATASTORE_PATH),
        ),
    );
"service" = dict(
    "Type", "forking",
    "ExecStart", format("/usr/bin/ceph-fuse --id=cephfs %s", CEPH_FUSE_DATASTORE_PATH),
    "ExecStop", format("/bin/umount %s", CEPH_FUSE_DATASTORE_PATH),
    "Restart", "on-failure",
    "RestartSec", 120,
    );
"install" = dict(
    "WantedBy", list("multi-user.target"),
    );
