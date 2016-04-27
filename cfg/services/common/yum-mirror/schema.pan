declaration template common/yum-mirror/schema;

@{
    Configures the reposnap script.
}
type reposnap = {
    "YUM_CONFIG" : string
    "REPO_PACKAGE_DIR" : string
    "SNAPSHOT_PKG" : string
};

bind "/software/components/metaconfig/services/{/etc/reposnap.conf}/contents" = reposnap;

type yum_mirror_main = {
    "reposdir" : string
    "exclude" ? string
};

@{
    Sets up the Yum mock configuration file, which only needs a repository directory.
}
type yum_mirror_conf = {
    "main" : yum_mirror_main
};

bind "/software/components/metaconfig/services/{/etc/yum.reposnap}/contents" = yum_mirror_conf;

type yum_mirror_repo = {
    "baseurl" ? type_absoluteURI
    "mirrorlist" ? type_absoluteURI
} with exists(SELF["baseurl"]) || exists(SELF["mirrorlist"]);

bind "/software/components/metaconfig/services/{/etc/reposnap.repos.d/repositories.repo}/contents" = yum_mirror_repo{};
