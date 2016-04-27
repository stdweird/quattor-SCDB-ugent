unique template common/gpfs/hadoop;

# add the symlinks
#  from fpo/hadoop-2.X to /var/mmfs/etc/ (< 2.7)
#  hadoop-2.X to /var/mmfs/etc/ (> 2.7)

"/software/components/symlink/links" = {
    versions = matches(GPFS_HADOOP_CONNECTOR_VERSION, '^(\d+)\.(\d+)\.(\d+)');

    names = list(
        'gpfs-connector-daemon',
        'install_script/gpfs-callback_start_connector_daemon.sh',
        'install_script/gpfs-callback_stop_connector_daemon.sh',
        );

    if ((to_long(versions[1]) > 2) || (to_long(versions[2]) >= 7)) {
        names = append(names, 'install_script/gpfs-log4j.properties');
        libsuffix = format('so.%s.%s.%s', versions[1], versions[2], versions[3]);
        subdir = 'hadoop';
    } else {
        libsuffix = '64.so';
        subdir = format('fpo/hadoop-%s.%s', versions[1], versions[2]);
    };

    foreach(idx;v;names) {
        basename = matches(v, '(/|^)([^/]*)$');
        append(dict(
            "name", format("/var/mmfs/etc/%s", basename[2]),
            "target", format("/usr/lpp/mmfs/%s/%s", subdir, v),
            "exists", false,
            "replace", dict("all","yes"),
            ));
    };

    # Fix issue with libgpfshadoop and containers not being able to find it
    append(dict(
        "name", "/usr/lib64/libgpfshadoop.so",
        "target", format("/usr/lpp/mmfs/%s/libgpfshadoop.%s", subdir, libsuffix),
        "exists", false,
        "replace", dict("all","yes"),
        ));

    # only since 2.7?
    append(dict(
        "name", format("/usr/lib64/libgpfshadoop.so.%s.%s", versions[1], versions[2]),
        "target", format("/usr/lpp/mmfs/%s/libgpfshadoop.%s", subdir, libsuffix),
        "exists", false,
        "replace", dict("all","yes"),
        ));

    SELF;
};
